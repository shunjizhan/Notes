// State variables are permanently stored in contract storage. This means they're written to the Ethereum blockchain. 
contract Example {
  // This will be stored permanently in the blockchain
  uint myUnsignedInteger = 100;
}

// creating a dynamic array of structs like this can be useful for storing structured data in your contract, kind of like a database.
Person[] people; // dynamic Array, we can keep adding to it

// You can declare an array as public, and Solidity will automatically create a getter method for it. Other contracts would then be able to read (but not write) to this array. So this is a useful pattern for storing public data in your contract.
Person[] public people;

// It's convention (but not required) to start function parameter variable names with an underscore (_) in order to differentiate them from global variables. We'll use that convention throughout our tutorial.
function eatHamburgers(string _name, uint _amount) {}

// In Solidity, functions are public by default. This means anyone (or any other contract) can call your contract's function and execute its code. This can make your contract vulnerable to attacks.
// Private function: only other functions within our contract will be able to call this function and add to the numbers array. 
// It's convention to start private function names with an underscore (_).
uint[] numbers;
function _addToArray(uint _number) private {
  numbers.push(_number);
}

// view function: it's only viewing the data but not modifying it. Doesn't actually change state in Solidity — e.g. it doesn't change any values or write anything.
function sayHello() public view returns (string) {}

// pure functions: you're not even accessing any data in the app. This function doesn't even read from the state of the app — its return value depends only on its function parameters.
function _multiply(uint a, uint b) private pure returns (uint) {
  return a * b;
}

// Events are a way for your contract to communicate that something happened on the blockchain to your app front-end, which can be 'listening' for certain events and take action when they happen.
event IntegersAdded(uint x, uint y, uint result);
function add(uint _x, uint _y) public {
  uint result = _x + _y;
  // fire an event to let the app know the function was called:
  IntegersAdded(_x, _y, result);
  return result;
}

// A mapping is essentially a key-value store for storing and looking up data
// For a financial app, storing a uint that holds the user's account balance:
mapping (address => uint) public accountBalance;
// Or could be used to store / lookup usernames based on userId
mapping (uint => string) userIdToName;

// In Solidity, there are certain global variables that are available to all functions. One of these is msg.sender, which refers to the address of the person (or smart contract) who called the current function. Note: In Solidity, function execution always needs to start with an external caller. A contract will just sit on the blockchain doing nothing until someone calls one of its functions. So there will always be a msg.sender.
// Using msg.sender gives you the security of the Ethereum blockchain — the only way someone can modify someone else's data would be to steal the private key associated with their Ethereum address.
mapping (address => uint) favoriteNumber;
function setMyNumber(uint _myNumber) public {
  // Update our `favoriteNumber` mapping to store `_myNumber` under `msg.sender`
  favoriteNumber[msg.sender] = _myNumber;
  // ^ The syntax for storing data in a mapping is just like with arrays
}
function whatIsMyNumber() public view returns (uint) {
  // Retrieve the value stored in the sender's address
  // Will be `0` if the sender hasn't called `setMyNumber` yet
  return favoriteNumber[msg.sender];
}

// require makes it so that the function will throw an error and stop executing if some condition is not true:
function sayHiToVitalik(string _name) public returns (string) {
  // Compares if _name equals "Vitalik". Throws an error and exits if not true.
  // (Side note: Solidity doesn't have native string comparison, so we
  // compare their keccak256 hashes to see if the strings are equal)
  require(keccak256(_name) == keccak256("Vitalik"));
  // If it's true, proceed with the function:
  return "Hi!";
}

// inheritance
// if you compile and deploy BabyDoge, it will have access to both catchphrase() and anotherCatchphrase() (and any other public functions we may define on Doge)
contract Doge {
  function catchphrase() public returns (string) {
    return "So Wow CryptoDoge";
  }
}
contract BabyDoge is Doge {
  function anotherCatchphrase() public returns (string) {
    return "Such Moon BabyDoge";
  }
}

// In Solidity, there are two places you can store variables — in storage and in memory. Storage refers to variables stored permanently on the blockchain. Memory variables are temporary, and are erased between external function calls to your contract.
// Most of the time you don't need to use these keywords because Solidity handles them by default. State variables (variables declared outside of functions) are by default storage and written permanently to the blockchain, while variables declared inside functions are memory and will disappear when the function call ends.
contract SandwichFactory {
  struct Sandwich {
    string name;
    string status;
  }
  Sandwich[] sandwiches;
  function eatSandwich(uint _index) public {
    // Sandwich mySandwich = sandwiches[_index];

    // ^ Seems pretty straightforward, but solidity will give you a warning
    // telling you that you should explicitly declare `storage` or `memory` here.

    // So instead, you should declare with the `storage` keyword, like:
    Sandwich storage mySandwich = sandwiches[_index];
    // ...in which case `mySandwich` is a pointer to `sandwiches[_index]`
    // in storage, and...
    mySandwich.status = "Eaten!";
    // ...this will permanently change `sandwiches[_index]` on the blockchain.

    // If you just want a copy, you can use `memory`:
    Sandwich memory anotherSandwich = sandwiches[_index + 1];
    // ...in which case `anotherSandwich` will simply be a copy of the 
    // data in memory, and...
    anotherSandwich.status = "Eaten!";
    // ...will just modify the temporary variable and have no effect 
    // on `sandwiches[_index + 1]`. But you can do this:
    sandwiches[_index + 1] = anotherSandwich;
    // ...if you want to copy the changes back into blockchain storage.
  }
}

// In addition to public and private, Solidity has two more types of visibility for functions: internal and external. 
// internal is the same as private, except that it's also accessible to contracts that inherit from this contract.
// external is similar to public, except that these functions can ONLY be called outside the contract — they can't be called by other functions inside that contract.


// For our contract to talk to another contract on the blockchain that we don't own, first we need to define an interface.
contract LuckyNumber {
  mapping(address => uint) numbers;

  function setNum(uint _num) public {
    numbers[msg.sender] = _num;
  }

  function getNum(address _myAddress) public view returns (uint) {
    return numbers[_myAddress];
  }
}
contract NumberInterface {  // this is the interface!!
  // we're only declaring the functions we want to interact with — in this case getNum
  // we're not defining the function bodies. Instead of curly braces ({ and }), we're simply ending the function declaration with a semi-colon (;).
  // So it kind of looks like a contract skeleton. This is how the compiler knows it's an interface.
  function getNum(address _myAddress) public view returns (uint);
}

// after you deploy a contract to Ethereum, it’s immutable, which means that it can never be modified or updated again.
// it often makes sense to have functions that will allow you to update key portions of the DApp.
// modifier
modifier onlyOwner() {
    require(msg.sender == owner);
    _;      // when function get called, onlyOwner get called first, when reach this line, return to function main body
}
function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
}

// In Solidity, your users have to pay every time they execute a function on your DApp using a currency called gas.
// How much gas is required to execute a function depends on how complex that function's logic is. Each individual operation has a gas cost based roughly on how much computing resources will be required to perform that operation (e.g. writing to storage is much more expensive than adding two integers). The total gas cost of your function is the sum of the gas costs of all its individual operations.


// You can pass a storage pointer to a struct as an argument to a private or internal function
function _doStuff(Zombie storage _zombie) internal {}

//  An important security practice is to examine all your public and external functions, and try to think of ways users might abuse them. 

// view functions don't cost any gas when they're called externally by a user.
// This is because view functions don't actually change anything on the blockchain – they only read the data. So marking a function with view tells web3.js that it only needs to query your local Ethereum node to run the function, and it doesn't actually have to create a transaction on the blockchain (which would need to be run on every single node, and cost gas).
// Note: If a view function is called internally from another function in the same contract that is not a view function, it will still cost gas. This is because the other function creates a transaction on Ethereum, and will still need to be verified from every node. So view functions are only free when they're called externally.

// You can use the memory keyword with arrays to create a new array inside a function without needing to write anything to storage. The array will only exist until the end of the function call, and this is a lot cheaper gas-wise than updating an array in storage
//declare an array in memory
function getArray() external pure returns(uint[]) {
  // Instantiate a new array in memory with a length of 3
  uint[] memory values = new uint[](3);
  // Add some values to it
  values.push(1);
  values.push(2);
  values.push(3);
  // Return the array
  return values;
}
// memory arrays must be created with a length argument (in this example, 3). They currently cannot be resized like storage arrays can with array.push(), although this may be changed in a future version of Solidity

// for loop
for (uint i = 1; i <= 10; i++) {}




