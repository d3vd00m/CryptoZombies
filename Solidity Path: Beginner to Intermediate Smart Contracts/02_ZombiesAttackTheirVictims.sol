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

    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // start here
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
