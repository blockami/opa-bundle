package blockami

import future.keywords.in


#Sell NFT 721
events[e] {
	input.logs[transfer].information.name == "Transfer"

    #Check Origin
	input.logs[transfer].information.parameters[from].name in ["src", "from"]
	input.logs[transfer].information.parameters[from].value == input.address
    
   	#Find ID parameter
	input.logs[transfer].information.parameters[tokenId].name in ["tokenId"]
    e := {
        "priority": 1000,
        "name": "transfer_nft",
        "additional_info": {
            "type": "ERC721",
            "collection": input.logs[transfer].raw_data.contract,
            "nft_id": input.logs[transfer].information.parameters[tokenId].value,
            "from": input.logs[transfer].information.parameters[from].value,
            "to": input.logs[transfer].information.parameters[to].value
        }
    }
}

#Buy NFT 721, also covers minting
events[e] {
	input.logs[transfer].information.name == "Transfer"

    #Check Origin
	input.logs[transfer].information.parameters[to].name in ["dst", "to"]
	input.logs[transfer].information.parameters[to].value == input.address
    
   	#Find ID parameter
	input.logs[transfer].information.parameters[tokenId].name in ["tokenId"]
    e := {
        "priority": 1000,
        "name": "transfer_nft",
        "additional_info": {
            "type": "ERC721",
            "collection": input.logs[transfer].raw_data.contract,
            "nft_id": input.logs[transfer].information.parameters[tokenId].value,
            "from": input.logs[transfer].information.parameters[from].value,
            "to": input.logs[transfer].information.parameters[to].value
        }
    }
}

#Sell NFT ERC1155
events[e] {
	#Filter events only for unstaked
	input.logs[transfer].information.name == "TransferSingle"

    #Check Destination
	input.logs[transfer].information.parameters[from].name in ["from", "_from"]
	input.logs[transfer].information.parameters[from].value == input.address
    
   	#Find ID parameter
	input.logs[transfer].information.parameters[id].name in ["id", "_id"]
    input.logs[transfer].information.parameters[value].name in ["value", "_value"]
    e := {
        "priority": 1000,
        "name": "transfer_nft",
        "additional_info": {
            "type": "ERC1155",
            "collection": input.logs[transfer].raw_data.contract,
            "nft_id": input.logs[transfer].information.parameters[id].value,
            "nft_amount": input.logs[transfer].information.parameters[value].value,
            "from": input.logs[transfer].information.parameters[from].value,
            "to": input.logs[transfer].information.parameters[to].value
        }
    }
}

#Sell NFT ERC1155, also cover minting
events[e] {
	#Filter events only for unstaked
	input.logs[transfer].information.name == "TransferSingle"

    #Check Destination
	input.logs[transfer].information.parameters[to].name in ["to", "_to"]
	input.logs[transfer].information.parameters[to].value == input.address
    
   	#Find ID parameter
	input.logs[transfer].information.parameters[id].name in ["id", "_id"]
    input.logs[transfer].information.parameters[value].name in ["value", "_value"]
    e := {
        "priority": 1000,
        "name": "transfer_nft",
        "additional_info": {
            "type": "ERC1155",
            "collection": input.logs[transfer].raw_data.contract,
            "nft_id": input.logs[transfer].information.parameters[id].value,
            "nft_amount": input.logs[transfer].information.parameters[value].value,
            "from": input.logs[transfer].information.parameters[from].value,
            "to": input.logs[transfer].information.parameters[to].value
        }
    }
}


events[e] {    
    input.logs[transfer].information.name == "TransferBatch"
    
    input.logs[transfer].information.parameters[tokenIds].name in ["ids"]
    input.logs[transfer].information.parameters[tokenAmounts].name in ["values"]

    input.logs[transfer].information.parameters[from].name in ["src", "from"]
    
    input.logs[transfer].information.parameters[to].name in ["dst", "to"]
	input.logs[transfer].information.parameters[to].value == input.address

    e := {
        "priority": 100,
    	"name": "transfer_nft",
        "additional_info": {
            "type": "ERC1155",
            "collection": input.logs[transfer].raw_data.contract,
            "nft_id": input.logs[transfer].information.parameters[tokenIds].value,
            "amount": input.logs[transfer].information.parameters[tokenAmounts].value,
            "from": input.logs[transfer].information.parameters[from].value,
            "to": input.logs[transfer].information.parameters[to].value,
        }
    }
}

events[e] {    
    input.logs[transfer].information.name == "TransferBatch"
    
    input.logs[transfer].information.parameters[tokenIds].name in ["ids"]
    input.logs[transfer].information.parameters[tokenAmounts].name in ["values"]

    input.logs[transfer].information.parameters[from].name in ["src", "from"]
	input.logs[transfer].information.parameters[from].value == input.address
    
    input.logs[transfer].information.parameters[to].name in ["dst", "to"]

    e := {
        "priority": 100,
    	"name": "transfer_nft",
        "additional_info": {
            "type": "ERC1155",
            "collection": input.logs[transfer].raw_data.contract,
            "nft_ids": input.logs[transfer].information.parameters[tokenIds].value,
            "amounts": input.logs[transfer].information.parameters[tokenAmounts].value,
            "from": input.logs[transfer].information.parameters[from].value,
            "to": input.logs[transfer].information.parameters[to].value,
        }
    }
}