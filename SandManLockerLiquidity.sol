/*_________   _____    _______  ________      _____      _____    _______   
 /   _____/  /  _  \   \      \ \______ \    /     \    /  _  \   \      \  
 \_____  \  /  /_\  \  /   |   \ |    |  \  /  \ /  \  /  /_\  \  /   |   \ 
 /        \/    |    \/    |    \|    `   \/    Y    \/    |    \/    |    \
/_______  /\____|__  /\____|__  /_______  /\____|__  /\____|__  /\____|__  /
One Thing I've Learned. You Can Know Anything. It's All There. You Just Have To Find It.
*/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract SandManLockerLiquidity is Ownable {
    using SafeERC20 for IERC20;

    uint256 public immutable UNLOCK_END_BLOCK;

    event Claim(IERC20 sandManToken, address to);


    /**
     * @notice Constructs the SandMan contract.
     */
    constructor(uint256 blockNumber) {
        UNLOCK_END_BLOCK = blockNumber;
    }

    /**
     * @notice claimSanManLiquidity
     * claimsandManToken allows the sandMan Team to send sandMan Liquidity to the new delirum kingdom.
     * It is only callable once UNLOCK_END_BLOCK has passed.
     * SandMan Liquidity Policy: https://docs.sandman.farm/token-info/sandman-token/liquidity-lock-policy
     */

    function claimSanManLiquidity(IERC20 sandManLiquidity, address to) external onlyOwner {
        require(block.number > UNLOCK_END_BLOCK, "SandMan is still dreaming...");

        sandManLiquidity.safeTransfer(to, sandManLiquidity.balanceOf(address(this)));

        emit Claim(sandManLiquidity, to);
    }
}
