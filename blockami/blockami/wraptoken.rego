package blockami

import future.keywords.in

events[e] {
    input.logs[deposit].information.name == "Deposit"
    input.logs[deposit].information.parameters[amountDeposit].name in ["wad", "value"]
    
    e := {
        "priority": 110,
        "name": "wrap_token",
        "additional_info": {
            "input": {
                "token": input.network,
                "amount": input.logs[deposit].information.parameters[amountDeposit].value
            }
        }
    }
}

events[e] {
    input.logs[withdraw].information.name == "Withdrawal"
    input.logs[withdraw].information.parameters[amountWithdraw].name in ["wad", "value"]
    
    e := {
        "priority": 110,
        "name": "unwrap_token",
        "additional_info": {
            "input": {
                "token": input.network,
                "amount": input.logs[withdraw].information.parameters[amountWithdraw].value
            }
        }
    }
}