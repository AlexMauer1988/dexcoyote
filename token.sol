// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";

contract Coyote is ERC20, Ownable {
    constructor() ERC20("Coyote", "HOWL") {}

    mapping(address => bool) private frozen;

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from,address to, uint amount) internal override {
        require(!frozen[from], "Account is frozen");
        super._beforeTokenTransfer(from, to, amount);
    }

    function setFrozen(address user) external onlyOwner {
        require(!frozen[user], "Account already is frozen");
        frozen[user] = true;
    }

    function removeFrozen(address user) external onlyOwner {
        require(frozen[user], "Account already is unfrozen");
        frozen[user] = false;
    }

    function isFrozen(address user) external view returns(bool) {
        return frozen[user];
    }
}
