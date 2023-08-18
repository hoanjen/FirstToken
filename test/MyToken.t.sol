// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";
import {MyToken} from "../src/MyToken.sol";


contract TokenTest is Test {
    MyToken hjToken;

    uint256 private constant _decimals = 10**18; 
    uint256 private constant _totalSupply = 10**8 * _decimals; 
    uint256 private constant _maxTotalSupply = 10**9 * _decimals;
    address private _hjAddress;
    address private _deployer;

    function setUp() public {
        _deployer = vm.addr(213);

        vm.startPrank(_deployer);

        hjToken = new MyToken(
            _totalSupply,
            _maxTotalSupply,
            'HoanJen Token',
            'HJ',
            _decimals
        );

        _hjAddress = address(hjToken);
    }

    function testTotalSupply_ShouldReturnTS_WhenGetTS() public {
        //execution
        uint256 totalSupply = hjToken.totalSupply();

        //assert
        assertEqUint(totalSupply, _totalSupply);
    }
    function testBanlanceOfDeployer() public {
        //execution
        uint256 totalDeployer = hjToken.balanceOf(_deployer);

        //assert
        assertEqUint(totalDeployer, _totalSupply);
    }

    function testTransfer() public {
        address alice = vm.addr(123);
        hjToken.transfer(alice, 10**7);
        // test: forge test --match-contract=TokenTest --mt=testTransfer  -vvvv
        assertEqUint(hjToken.balanceOf(alice), 10**7);
    }
    

    

}