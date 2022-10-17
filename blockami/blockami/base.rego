package blockami

import future.keywords.in

events[e] {
    input.transaction.raw_data.input != ""
    to_number(input.transaction.raw_data.value) > 0
    e := {
        "priority": 10,
    	"name": "tx_value",
        "value": {
        	"amount": input.transaction.raw_data.value,
        	"token": input.network
        },
        "additional_info": {
            "from": input.transaction.raw_data.from,
            "to": input.transaction.raw_data.to,
        }
    }
}

events[e] {
    to_number(input.transaction.raw_data.value) > 0
    e := {
        "priority": 100,
    	"name": "transfer_token",
        "value": {
        	"amount": input.transaction.raw_data.value,
        	"token": input.network
        },
        "additional_info": {
            "from": input.transaction.raw_data.from,
            "to": input.transaction.raw_data.to
        }
    }
}

events[e] {    
    input.logs[transferTo].information.name == "Transfer"
    input.logs[transferTo].information.parameters[amount].name in ["wad", "value", "value"]
    input.logs[transferTo].information.parameters[from].name in ["src", "from"]
	input.logs[transferTo].information.parameters[from].value == input.address
    input.logs[transferTo].information.parameters[to].name in ["dst", "to"]

    e := {
        "priority": 100,
    	"name": "transfer_token",
        "value": {
        	"amount": input.logs[transferTo].information.parameters[amount].value,
        	"token": input.logs[transferTo].raw_data.contract
        },
        "additional_info": {
            "from": input.logs[transferTo].information.parameters[from].value,
            "to": input.logs[transferTo].information.parameters[to].value
        }
    }
}

events[e] {    
    input.logs[transferTo].information.name == "Transfer"
    input.logs[transferTo].information.parameters[amount].name in ["wad", "value", "value"]
    input.logs[transferTo].information.parameters[from].name in ["src", "from"]
    input.logs[transferTo].information.parameters[to].name in ["dst", "to"]
	input.logs[transferTo].information.parameters[to].value == input.address

    e := {
        "priority": 100,
    	"name": "transfer_token",
        "value": {
        	"amount": input.logs[transferTo].information.parameters[amount].value,
        	"token": input.logs[transferTo].raw_data.contract
        },
        "additional_info": {
            "from": input.logs[transferTo].information.parameters[from].value,
            "to": input.logs[transferTo].information.parameters[to].value
        }
    }
}