package blockami

import future.keywords.in

events[e] {    
    input.transaction.information.method in ["stake"]
    input.transaction.raw_data.to in ["0xC8C436271f9A6F10a5B80c8b8eD7D0E8f37a612d"]

    input.logs[transfer].information.name == "Transfer"
    input.logs[transfer].information.parameters[from].name in ["src", "from", "_from"]
	input.logs[transfer].information.parameters[from].value == input.address
    
    e := {
        "priority": 2000,
    	"name": "stake_ohm",
        "value": {
            "token": input.logs[transfer].raw_data.contract,
            "amount": input.logs[transfer].information.parameters[from].value
        }
    }
}

events[e] {    
    input.transaction.information.method in ["unstake"]
    input.transaction.raw_data.to in ["0xFd31c7d00Ca47653c6Ce64Af53c1571f9C36566a"]

    input.logs[transfer].information.name == "Transfer"
    input.logs[transfer].information.parameters[from].name in ["src", "from", "_from"]
	input.logs[transfer].information.parameters[from].value == input.address
    
    e := {
        "priority": 2000,
    	"name": "unstake_ohm",
        "value": {
            "token": input.logs[transfer].raw_data.contract,
            "amount": input.logs[transfer].information.parameters[from].value
        }
    }
}

