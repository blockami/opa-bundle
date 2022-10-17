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
    input.logs[transfer].information.name == "Transfer"
    input.logs[transfer].information.parameters[amount].name in ["wad", "value", "_value"]
    input.logs[transfer].information.parameters[from].name in ["src", "from", "_from"]
	input.logs[transfer].information.parameters[from].value == input.address
    input.logs[transfer].information.parameters[to].name in ["dst", "to", "_to"]

    e := {
        "priority": 100,
    	"name": "transfer_token",
        "value": {
        	"amount": input.logs[transfer].information.parameters[amount].value,
        	"token": input.logs[transfer].raw_data.contract
        },
        "additional_info": {
            "from": input.logs[transfer].information.parameters[from].value,
            "to": input.logs[transfer].information.parameters[to].value
        }
    }
}

events[e] {    
    input.logs[transfer].information.name == "Transfer"
    input.logs[transfer].information.parameters[amount].name in ["wad", "value", "_value"]
    input.logs[transfer].information.parameters[from].name in ["src", "from", "_from"]
    input.logs[transfer].information.parameters[to].name in ["dst", "to", "_to"]
	input.logs[transfer].information.parameters[to].value == input.address

    e := {
        "priority": 100,
    	"name": "transfer_token",
        "value": {
        	"amount": input.logs[transfer].information.parameters[amount].value,
        	"token": input.logs[transfer].raw_data.contract
        },
        "additional_info": {
            "from": input.logs[transfer].information.parameters[from].value,
            "to": input.logs[transfer].information.parameters[to].value
        }
    }
}