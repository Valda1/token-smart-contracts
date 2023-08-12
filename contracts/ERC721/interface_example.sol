// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

interface IERC721 {
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    function balanceOf(address _owner) external view returns (uint256);
    function ownerOf(uint256 _tokenId) external view returns (address);
    function transferFrom(address _from, address _to, uint256 _tokenId) external;
}

interface IERC721Receiver {
    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes calldata _data) external returns (bytes4);
}

contract Contract is IERC721, IERC721Receiver {
    address private tokenOwner;

    constructor() {
        tokenOwner = msg.sender;
    }

    function balanceOf(address _owner) external view override returns (uint256) {
        require(_owner != address(0), "Invalid address");
        return (_owner == tokenOwner) ? 1 : 0;
    }

    function ownerOf(uint256 _tokenId) external view override returns (address) {
        require(_tokenId == 1, "Token not found");
        return tokenOwner;
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external override {
        require(msg.sender == _from || msg.sender == ownerOf(_tokenId), "Unauthorized transfer");
        require(_from == tokenOwner, "Token not owned by sender");

        tokenOwner = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes calldata _data) external override returns (bytes4) {
        // Handle received token here
        // You can perform additional checks or actions based on the received data
        // Return the ERC721_RECEIVED value to indicate successful token reception
        return bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
    }
}