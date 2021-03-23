// We're going to be implementing the functionality for our zombies to feed and multiply. 
// Let's put this logic into its own contract ZombieFeeding that inherits all the methods from ZombieFactory.
// Our code was getting pretty long, so we split it up into multiple files to make it more manageable.
// Now that we've set up a multi-file structure, we need to use import to read the contents of the other file

pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {
  
  // It's time to give our zombies the ability to feed and multiply!
  
  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
  
    // We don't want to let someone else feed our zombie! So first, let's make sure we own this zombie.
    
    require(msg.sender == zombieToOwner[_zombieId]);
    
    // Now the function declare a local Zombie named myZombie (which will be a storage pointer). 
    // Set this variable to be equal to index _zombieId in our zombies array.
    
    Zombie storage myZombie = zombies[_zombieId];

}
