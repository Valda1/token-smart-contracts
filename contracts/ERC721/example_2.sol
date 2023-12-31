// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Contract is ERC721, Ownable{
    uint256 public mintPrice = 0.05 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnabled;
    mapping(address => uint256) public mintedWallets;

    constructor() payable ERC721("Contract", "SC"){
        maxSupply = 2;
    }

    function toggleIsMintEnabled() external onlyOwner{
        isMintEnabled = !isMintEnabled;
    }

    function setMaxSupply(uint256 maxSupply_) external onlyOwner{
        maxSupply = maxSupply_;
    }

    function mint() external payable{
        require(isMintEnabled, "Minting not enabled!");
        require(mintedWallets[msg.sender] < 1, "Exceeds max per wallet!");
        require(msg.value == mintPrice, "Wrong value!");
        require(maxSupply > totalSupply, "Sold out!");

        mintedWallets[msg.sender]++;
        totalSupply++;
        uint256 tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);
    }
}