package blockami

import future.keywords.in

#Add LP
events[e] {
	input.transaction.information.parameters[token1].name in ["token", "tokenA"]

    input.logs[transferT1In].information.name == "Transfer"
    input.logs[transferT1In].information.parameters[to1].name in ["dst", "to"]
    input.logs[transferT1In].information.parameters[amountT1].name in ["wad", "amount", "value"]

	input.logs[transferT1In].raw_data.contract == input.transaction.information.parameters[token1].value

    input.logs[transferT2In].information.name == "Transfer"
    input.logs[transferT2In].information.parameters[to2].name in ["dst", "to"]
	input.logs[transferT2In].information.parameters[amountT2].name in ["wad", "amount", "value"]

	##different contracts
    input.logs[transferT1In].raw_data.contract != input.logs[transferT2In].raw_data.contract

    ##sends both tokens to same LP address
	input.logs[transferT1In].information.parameters[to].value == input.logs[transferT2In].information.parameters[to].value

    input.logs[mint].information.name == "Mint"
    
    input.logs[transferLP].information.name == "Transfer"
    input.logs[transferLP].information.parameters[amountFrom].name in ["wad", "value", "value"]
    input.logs[transferLP].information.parameters[to3].name in ["dst", "to"]
	input.logs[transferLP].information.parameters[to3].value == input.address
    
    e := {
        "priority": 2000,
        "name": "lp_deposit",
        "additional_info": {
            "token1": {
                "token": input.logs[transferT1In].raw_data.contract,
                "amount": input.logs[transferT1In].information.parameters[amountT1].value
            },
            "token2": {
                "token": input.logs[transferT2In].raw_data.contract,
                "amount": input.logs[transferT2In].information.parameters[amountT2].value
            }
        }
    }
}

#Remove LP token-token
events[e] {
	input.transaction.information.parameters[token1].name in ["token", "tokenA"]

    input.logs[transferT1In].information.name == "Transfer"
    input.logs[transferT1In].information.parameters[to1].name in ["dst", "to"]
    input.logs[transferT1In].information.parameters[to1].value == input.address
    input.logs[transferT1In].information.parameters[amountT1].name in ["wad", "amount", "value"]

	input.logs[transferT1In].raw_data.contract == input.transaction.information.parameters[token1].value

    input.logs[transferT2In].information.name == "Transfer"
    input.logs[transferT2In].information.parameters[to2].name in ["dst", "to"]
    input.logs[transferT2In].information.parameters[to2].value == input.address
	input.logs[transferT2In].information.parameters[amountT2].name in ["wad", "amount", "value"]

	##different contracts
    input.logs[transferT1In].raw_data.contract != input.logs[transferT2In].raw_data.contract

    input.logs[burn].information.name == "Burn"
    
    input.logs[transferLP].information.name == "Transfer"
    input.logs[transferLP].information.parameters[amountFrom].name in ["wad", "value", "value"]
    input.logs[transferLP].information.parameters[from].name in ["src", "from"]
	input.logs[transferLP].information.parameters[from].value == input.address
    
    e := {
        "priority": 2000,
        "name": "lp_remove",
        "additional_info": {
            "token1": {
                "token": input.logs[transferT1In].raw_data.contract,
                "amount": input.logs[transferT1In].information.parameters[amountT1].value
            },
            "token2": {
                "token": input.logs[transferT2In].raw_data.contract,
                "amount": input.logs[transferT2In].information.parameters[amountT2].value
            }
        }
    }
}

#Remove LP token-ETH
events[e] {
	input.transaction.information.parameters[token1].name in ["token", "tokenA"]

    input.logs[transferT1In].information.name == "Transfer"
    input.logs[transferT1In].information.parameters[to].name in ["dst", "to"]
    input.logs[transferT1In].information.parameters[to].value == input.address
    input.logs[transferT1In].information.parameters[amountT1].name in ["wad", "amount", "value"]

	input.logs[transferT1In].raw_data.contract == input.transaction.information.parameters[token1].value

    input.logs[transferT2In].information.name == "Withdrawal"
	input.logs[transferT2In].information.parameters[amountT2].name in ["wad", "amount", "value"]

	##different contracts
    input.logs[burn].information.name == "Burn"
    
    input.logs[transferLP].information.name == "Transfer"
    input.logs[transferLP].information.parameters[amountLP].name in ["wad", "value", "value"]
    input.logs[transferLP].information.parameters[from].name in ["src", "from"]
	input.logs[transferLP].information.parameters[from].value == input.address
    
    e := {
        "priority": 2000,
        "name": "lp_remove",
        "additional_info": {
            "token1": {
                "token": input.logs[transferT1In].raw_data.contract,
                "amount": input.logs[transferT1In].information.parameters[amountT1].value
            },
            "token2": {
                "token": input.logs[transferT2In].raw_data.contract,
                "amount": input.logs[transferT2In].information.parameters[amountT2].value
            }
        }
    }
}