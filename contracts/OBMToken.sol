//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

// contract-1

contract OBMToken is Ownable, AccessControl, ERC20Snapshot {
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE"); 

    constructor() ERC20("Ohbyeongmin", "OBM") {}

    function setupBurnerRole(address burner) external onlyOwner {
        _setupRole(BURNER_ROLE, burner);
    }

    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) external {
        require(balanceOf(msg.sender) > 0 || hasRole(BURNER_ROLE, msg.sender));
        _burn(account, amount);
    }

    function snapshot() external {
        _snapshot();
    }
}