// SPDX-License-Idwentifier: MIT

pragma solidity 0.8.19;

contract ManualToken {
    mapping(address => uint256) private s_balances;

    function name() public pure returns (string memory) {
        return "Manual Token";

        // we can do:
        // string public name = "Manual Token"; / its the same as the function above
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether; // 100 tokens with 18 decimals
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _amount) public {
        uint256 previousBalances = balanceOf(msg.sender) + balanceOf(_to);
        s_balances[msg.sender] -= _amount;
        s_balances[_to] += _amount;
        require(balanceOf(msg.sender) + balanceOf(_to) == previousBalances);
    }
}
