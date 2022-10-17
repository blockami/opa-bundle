package blockami

import future.keywords.in

#0xd9e1ce17f2641f24ae83637ab66a2cca9c378b9f Sushi
#0x7a250d5630b4cf539739df2c5dacb4c659f2488d Uni
#0x1111111254fb6c44bac0bed2854e76f90643097d 1inch

#Swap ETH to Token
events[e] {
    input.logs[transferOut].information.name == "Transfer"
    input.logs[transferOut].information.parameters[amountFrom].name in ["wad", "amount", "value", "_value"]
    input.logs[transferOut].information.parameters[to].name in ["dst", "to", "_to"]
	input.logs[transferOut].information.parameters[to].value == input.address

    input.logs[deposit].information.name == "Deposit"
    input.logs[deposit].information.parameters[amountDeposit].name in ["wad", "value"]
    
    e := {
        "priority": 1000,
        "name": "swap",
        "value": {
            "token": input.logs[deposit].raw_data.contract,
            "amount": input.logs[deposit].information.parameters[amountDeposit].value
        },
        "additional_info": {
            "input": {
                "token": input.logs[deposit].raw_data.contract,
                "amount": input.logs[deposit].information.parameters[amountDeposit].value
            },
            "output": {
                "token": input.logs[transferOut].raw_data.contract,
                "amount": input.logs[transferOut].information.parameters[amountFrom].value
            }
        }
    }
}

#Swap token to other token
events[e] {    
    input.logs[transferFrom].information.name == "Transfer"
    input.logs[transferFrom].information.parameters[amountFrom].name in ["wad", "value", "value", "_value"]
    input.logs[transferFrom].information.parameters[from].name in ["src", "from", "_from"]
	input.logs[transferFrom].information.parameters[from].value == input.address

    input.logs[transferTo].information.name == "Transfer"
    input.logs[transferTo].information.parameters[amountTo].name in ["wad", "value", "value"]
    input.logs[transferTo].information.parameters[dst].name in ["dst", "to"]
	input.logs[transferTo].information.parameters[dst].value == input.address
    
    input.logs[transferFrom].raw_data.contract != input.logs[transferTo].raw_data.contract

    e := {
        "priority": 1000,
        "name": "swap",
        "value": {
            "token": input.logs[transferFrom].raw_data.contract,
            "amount": input.logs[transferFrom].information.parameters[amountFrom].value
        },
        "additional_info": {
            "input": {
                "token": input.logs[transferFrom].raw_data.contract,
                "amount": input.logs[transferFrom].information.parameters[amountFrom].value
            },
            "output": {
                "token": input.logs[transferTo].raw_data.contract,
                "amount": input.logs[transferTo].information.parameters[amountTo].value
            }
        }
    }
}

#Swap token to ETH
events[e] {    
    input.logs[transferFrom].information.name == "Transfer"
    input.logs[transferFrom].information.parameters[amountFrom].name in ["wad", "value", "value", "_value"]
    input.logs[transferFrom].information.parameters[from].name in ["src", "from", "_from"]
	input.logs[transferFrom].information.parameters[from].value == input.address
    
    input.logs[withdrawal].information.name == "Withdrawal"
    input.logs[withdrawal].information.parameters[amountWith].name in ["wad", "value"]

    e := {
        "priority": 1000,
        "name": "swap",
        "value": {
        	"token": input.logs[transferFrom].raw_data.contract,
            "amount": input.logs[transferFrom].information.parameters[amountFrom].value
        },
        "additional_info": {
            "input": {
                "token": input.logs[transferFrom].raw_data.contract,
                "amount": input.logs[transferFrom].information.parameters[amountFrom].value
            },
            "output": {
                "token": input.logs[withdrawal].raw_data.contract,
                "amount": input.logs[withdrawal].information.parameters[amountWith].value
            }
        }
    }
}