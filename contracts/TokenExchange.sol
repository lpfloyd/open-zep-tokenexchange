// contracts/TokenExchange.sol
pragma solidity ^0.5.0;

// Import base Initializable contract
import "@openzeppelin/upgrades/contracts/Initializable.sol";

// Import the IERC20 Interface and SafeMath library
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";

contract TokenExchange is Initializable {
  using SafeMath for uint256;

  // Contract state: exchange rate and token
  uint256 public rate;
  IERC20 public token;
  address public owner;

  // Initializer function (replaces constructor)
  function initialize(uint256 _rate, IERC20 _token) public initializer {
    rate = _rate;
    token = _token;
  }

  // Send tokens back to sender usuing predefined exchange rate
  function() external payable {
    uint256 tokens = msg.value.mul(rate);
    token.transfer(msg.sender, tokens);
  }

  function withdraw() public {
    require(msg.sender == owner, "Address not allowed to call this function");
    msg.sender.transfer(address(this).balance);
  }

  function setOwner(address _owner) public {
    require(owner == address(0), "Owner already set, cannot modify!");
    owner = _owner;
  }
}
