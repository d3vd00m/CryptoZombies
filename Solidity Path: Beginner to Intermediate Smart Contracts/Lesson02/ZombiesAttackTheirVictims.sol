// we're going to make our app more game-like: 
// We're going to make it multi-player, 
// and we'll also be adding a more fun way to create zombies
// instead of just generating them randomly.
// When a zombie feeds, it infects the host with a virus. 
// The virus then turns the host into a new zombie that joins your army. 
// The new zombie's DNA will be calculated from the previous zombie's DNA and the host's DNA.

pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;
    
    // Let's make our game multi-player by giving the zombies in our database an owner.
    // To store zombie ownership, we're going to use two mappings: 
    // one that keeps track of the address that owns a zombie, 
    // and another that keeps track of how many zombies an owner has.
    
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;
    
    // Let's update our _createZombie method from lesson 1 to assign ownership of the zombie 
    // to whoever called the function.
    
    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        
        // First, after we get back the new zombie's id, let's update our zombieToOwner 
        //mapping to store msg.sender under that id.
        
        zombieToOwner[id] = msg.sender;
        
        // Second, let's increase ownerZombieCount for this msg.sender
        
        ownerZombieCount[msg.sender]++;
        
        emit NewZombie(id, _name, _dna);
    }
    
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    // In our zombie game, we don't want the user to be able to create unlimited zombies in their 
    // army by repeatedly calling createRandomZombie.
    // We want that each player can only call the function once when they first start the game 
    // in order to create the initial zombie in their army.
      
    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}

// we're going to be implementing the functionality for our zombies to feed and multiply. 
// Let's put this logic into its own contract ZombieFeeding that inherits all the methods from ZombieFactory.

contract ZombieFeeding is ZombieFactory {
    
}
