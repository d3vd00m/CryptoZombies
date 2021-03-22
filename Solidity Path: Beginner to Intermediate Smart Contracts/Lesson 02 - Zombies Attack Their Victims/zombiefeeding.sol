// We're going to be implementing the functionality for our zombies to feed and multiply. 
// Let's put this logic into its own contract ZombieFeeding that inherits all the methods from ZombieFactory.
// Our code was getting pretty long, so we split it up into multiple files to make it more manageable.
// Now that we've set up a multi-file structure, we need to use import to read the contents of the other file

pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {

}
