// We are going to build a "Zombie Factory" to build an army of zombies.
// Our factory will maintain a database of all zombies in our army.
// Our factory will have a function for creating new zombies.
// Each zombie will have a random and unique appearance.
// The zombie's appearance will be based on its "Zombie DNA" (a 16-digit integer).

pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    // Define an event to show when a new zombie is created.

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    
    // Define a struct variable with two zombie's properties.
    
    struct Zombie {
        string name;
        uint dna;
    }
    
    // Define a public array of struct to store the army of zombies.
 
    Zombie[] public zombies;
    
    // Define a private function to create the zombie.

    function _createZombie(string memory _name, uint _dna) private {
    
    // Create the new zombie with the function arguments (Zombie(_name, _dna)) and add it to the zombies public array (zombie.push).
    // Define the variable id that define the array index of the zombie we just added (the first array index is 0).
    
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        
    // Call the event for the creation of the new zombie.
    
        emit NewZombie(id, _name, _dna);
    }
    
    // Define a private function that generates a random DNA number from a string.
    
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }
    
    // Now put all the functions togheter by creating a public function that takes an input, the zombie's name, 
    // and uses the name to create a zombie with random DNA.
    
    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
