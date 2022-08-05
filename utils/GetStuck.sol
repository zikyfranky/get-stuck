// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GetStuck is Ownable {
    /// @notice Get stuck tokens in the contract
    /// @dev Function can be overriden
    /// @param token The address of the token stuck in the contract
    /// @param receiver The address of who would receive the stuck token
    function getStuckToken(IERC20 token, address receiver)
        public
        virtual
        onlyOwner
    {
        uint256 amount = token.balanceOf(address(this));
        token.transfer(receiver, amount);
    }

    /// @notice Get stuck eth in the contract
    /// @dev Function can be overriden
    /// @param receiver The address of who would receive the stuck eth
    function getStuckETH(address receiver) public virtual onlyOwner {
        uint256 amount = address(this).balance;
        (bool success, ) = payable(receiver).call{value: amount}("");

        require(success, "transfer failed");
    }
}
