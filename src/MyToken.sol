// SPDX-License-Identifier: UNLICENSED

// author: hoanjen

pragma solidity ^0.8.0;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";


contract MyToken is IERC20 {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;
    uint256 private _maxTotalSupply;
    string private _name;
    string private _symbol;
    uint256 private _decimals;
    address private _owner;

    constructor(uint256 totalSupply_, uint maxTotalSupply_, string memory name_,  string memory symbol_, uint256 decimals_){
        _totalSupply = totalSupply_;
        _maxTotalSupply = maxTotalSupply_;
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
        _owner = msg.sender;
        _balances[msg.sender] = totalSupply_;
    }

    function getOwner() external view returns (address) {
        return _owner;
    }

    function changeOwner(address newOwner_) external returns (bool) {
        require(msg.sender == _owner, 'You are not a owner');
        _owner = newOwner_;
        
        return true;
    }

    function totalSupply() external override view returns (uint256){
        return _totalSupply;
    }


    function balanceOf(address account_) external override view returns (uint256){
        return _balances[account_];
    }


    function transfer(address to, uint256 amount) external override returns (bool){
        require(amount > 0,  "Amount must be greater than 0");
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        _balances[msg.sender] -= amount;
        _balances[to] += amount;

        emit Transfer(msg.sender, to, amount);

        return true;
    }


    function allowance(address owner, address spender) external override view returns (uint256){
        return _allowances[owner][spender];
    }


    function approve(address spender, uint256 amount) external override returns (bool){
        require(amount > 0,  "Amount must be greater than 0");
        _allowances[msg.sender][spender] += amount;

        emit Approval(msg.sender, spender, amount);
        return true;
    }


    function transferFrom(address from, address to, uint256 amount) external override returns (bool){
        require(amount > 0, "Amount must be greater than 0");
        require(_balances[from] >= amount, "Insufficient balance");
        require(_allowances[from][to] >= amount , "Insufficient allowance");

        _balances[from] -= amount;
        _balances[to] += amount;
        _allowances[from][to] -= amount;

        emit Transfer(from, to, amount);
        return true;
    }
    
}


