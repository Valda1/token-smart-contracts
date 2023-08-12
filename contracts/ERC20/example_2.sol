// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    address public admin;

    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 10000 * 10 ** 18);
        admin = msg.sender;
    }

    function mint(address to, uint amount) external{
        require (admin == msg.sender,"Only Admin can call this");
        _mint(to, amount);
    }

    function burn(uint amount) external{
        _burn(msg.sender, amount);
    } 


}