// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

error NotOwner();

struct Person {
    uint256 favoriteNumber;
    string name;
}

contract SimpleStorage {
    uint256 public myFavoriteNumber;

    Person[] public listOfPeople;
    mapping(string => uint256) public nameToFavoriteNumber;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function store(uint256 _favoriteNumber) public onlyOwner {
        myFavoriteNumber = _favoriteNumber;
    }

    function addPerson(
        string calldata _name,
        uint256 _favoriteNumber
    ) public onlyOwner {
        listOfPeople.push(
            Person({name: _name, favoriteNumber: _favoriteNumber})
        );
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }
}
