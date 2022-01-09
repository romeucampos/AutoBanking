// SPDX-License_Identifier: MIT
pragma solidity 0.7.0;

contract AutoBanking {
    mapping(address => uint) public userAccount;
    mapping(address => bool) public userExists;

    function createAcc() public payable returns (string memory) {
        require(userExists[msg.sender] == false, "Account Already Created");
        if(msg.value == 0) {
            userAccount[msg.sender] = 0;
            userExists[msg.sender] = true;
            return "Account created";
        }
        
        require(userExists[msg.sender] == false, "Acconut Already Created");
        userAccount[msg.sender] = msg.value;
        userExists[msg.sender] = true;
        return "Account Created";
    }

    function deposit() public payable returns (string memory) {
        require(userExists[msg.sender] == true, "Account is not created");
        require(msg.value > 0, "Value for deposit is Zero");
        userAccount[msg.sender] += msg.value;
        return "Deposited Succesfully";
    }

    function withdraw(uint amount) public payable returns (string memory) {
        require(userAccount[msg.sender] > amount, "Insufficeint balance in Bank Account");
        require(userExists[msg.sender] == true, "Account is not created");
        require(amount > 0, "Enter non-zero value for withdrawal");
        userAccount[msg.sender] -= amount;
        msg.sender.transfer(amount);
        return "Withdrawal Succesful";

    }

    function transferAmount(address payable userAddress, uint amount) public returns (string memory) {
        require(userAccount[msg.sender] > amount, "Insufficeint balance in Bank account");
        require(userExists[msg.sender] == true, "Account is not created");
        require(userExists[userAddress] == true, "to Transfer account does not exists in bank accounts");
        require(amount > 0, "Enter non-zero value for sending");
        userAccount[msg.sender] -= amount;
        userAccount[userAddress] += amount;

    }

    function sendAmount(address payable toAddress, uint amount) public payable returns(string memory) {
        require(amount > 0, "Enter non-zero value for withdrawal");
        require(userExists[msg.sender] == true, "Account is not created");
        require(userAccount[msg.sender] > amount, "Insufficeint balance in Bank account");
        userAccount[msg.sender] -= amount;
        toAddress.transfer(amount);
        return "Transfer Success";

    }

    function userBalance() public view returns(uint) {
        return userAccount[msg.sender];
    }

    function accountExist() public view returns(bool) {
        return userExists[msg.sender];
    }

}