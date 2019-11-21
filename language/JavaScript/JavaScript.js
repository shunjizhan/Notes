// There are three essential data types in JavaScript: strings, numbers, and booleans.
// We can write out anything to the console with console.log.

confirm("I feel awesome!");
prompt("What is your name?");

Math.random(); 		// 0-1
Math.random() * 50;	// 0-50
Math.floor(Math.random() * 50);	// 0-49 whole number

var strength = 'you';
console.log('Hello ', strength); // Hello  you

var myPet = 'armadillo';
console.log('I own a pet ' + myPet + '.'); // 'I own a pet armadillo.'

console.log('muggle\'s life.');	// muggle's life.

var stopLight = 'green';
if (stopLight === 'red') {
  console.log('Stop');
} else if (stopLight === 'yellow') {
  console.log('Slow down');
} else {
  console.log('Caution, unknown!');
}

var groceryItem = 'papaya';
switch (groceryItem) {
  case 'tomato':
    console.log('Tomatoes are $0.49');
    break;
  case 'lime':
    console.log('Limes are $1.49');
    break;

  default:
    console.log('Invalid item');
    break;
}

function workoutJournal(miles, avgTime) {
  console.log('I ran ' + miles + ' miles at an average of ' + avgTime + ' per mile.');
}
workoutJournal('3');	// I ran 3 miles at an average of undefined per mile.

// If you write a variable outside of a function in JavaScript, it's in the global scope and can be used by any other part of the program,
// When we write variables inside a function, only that function has access to its own variables. Therefore, they are in the functional scope.

//***** Array *****//

var hello = 'Hello World';
console.log(hello[0]);	// H 

var list = ['a','b','c'];
var item = list[0];
console.log(list);		// [ 'a', 'b', 'c' ]
console.log(item);		// a
console.log(list.length); 	// 3

var bucketList = ['item 0', 'item 1', 'item 2'];
bucketList.push('item 3', 'item 4');	// ['item 0', 'item 1', 'item 2', 'item 3', 'item 4']

var bucketList = ['item 0', 'item 1', 'item 2'];
bucketList.pop();	// [ 'item 0', 'item 1' ]

var vacationSpots = ['a','b','c'];
for(var i=0; i<vacationSpots.length; i++) {
  console.log(vacationSpots[i]);
}

var mix = [42, true, "towel"];	// this is OK

//***** JQuery *****//
// The Document Object Model, commonly referred to as the DOM', is the term for elements in an HTML file. Elements are any HTML code denoted by HTML tags, like <div>, <a>, or <p>

function main() {}
$(document).ready(main);	// main is call back function

$('.class')
$('#id')

var $skillset = $('.skillset');	// It is a common convention to name variables that hold jQuery selectors with a dollar sign $.

$('.class').hide();	// hide function will add the CSS property display: none to the DOM element from the page, which will hide it.
$('.class').show();	
$('.class').toggle();	// combine hide and show
$('.class').slideToggle(600);	// animated toggle

$('.class').fadeIn(600);	// We must start with an element that is not currently displayed on the page.

// We can select the specific element we clicked on with the jQuery selector $(this).
$('.class').on('click', function() {
  $(this).toggleClass('active');	// add or delete a class
  var myClass = $(this).attr('class');	// get the element's class 
});

// <div class='item-one'> ... </div>
// <div class='item-two'> ... </div>
$('.item-one').next().hide();	// hide item-two

$('.class').text('Hello world!');	// change the text

//***** Objects *****//
// There are two ways to create an object: using object literal notation and using the object constructor.

// object literal notation:
var myObject = {
    key: value,
    key: value,
    key: value
};

// object constructor:
var bob = new Object();
bob.age = 30;		// both OK
bob["age"] = 30;	// both OK
bob.setAge = function (newAge){ bob.age = newAge; };
bob.setAge(40);

// an advantage of bracket notation is that we are not restricted to just using strings in the brackets. We can also use variables whose values are property names:
var someObj = {propName: someValue};
var kk = "propName";
var getValue = someObj[kk];

// this keyword
var phonebookEntry = {};
phonebookEntry.name = 'Oxnard Montalvo';
phonebookEntry.number = '(555) 555-5555';
phonebookEntry.phone = function() {
  console.log('Calling ' + this.name + ' at ' + this.number + '...');
};
phonebookEntry.phone();

// re-use a function
var setAge = function (newAge) { this.age = newAge; };
var bob = new Object();
var susan = new Object();
bob.age = 30;
susan.age = 25;
bob.setAge = setAge;
susan.setAge = setAge;
bob.setAge(50);
susan.setAge(35);

var rectangle = new Object();
rectangle.height = 3;
rectangle.setHeight = function(newHeight) {
  this.height = newHeight;
};
rectangle.setHeight(6);

// constructor
function Person(name,age) {
  this.name = name;
  this.age = age;
}
var bob = new Person("Bob Smith", 30);
var susan = new Person("Susan Jordan", 25);

// constructor with default properties
function Person(name,age) {
  this.name = name;
  this.age = age;
  this.species = "Homo Sapiens";
}

// constructor with function
function Rabbit(adjective) {
    this.adjective = adjective;
    this.describeMyself = function() {
        console.log("I am a " + this.adjective + " rabbit");
    };
}
rabbit1 = new Rabbit("fluffy");
rabbit2 = new Rabbit("happy");
rabbit1.describeMyself();
rabbit2.describeMyself();

var james = {
    job: "programmer",
    speak: function() {}
};

var family = new Array();	// an array is also an object
family[0] = new Person("alice", 40);
family[1] = new Person("bob", 42);

var someObject = 32;
console.log(typeof someObject);	// number

// see if an object has a particular property.
var myObj = { name: "hello" };
console.log( myObj.hasOwnProperty('name') ); // true
console.log( myObj.hasOwnProperty('nickname') ); // false

var dog = {
  species: "bulldog",
  age: 3
};
for(var property in dog) {   // "property" bit can be any placeholder name you like.
  console.log(property);  // print all property names
}
for(var x in dog) {
  console.log(dog[x]);  // print all property values
}

function Person(name, age) { this.name = name; }
var printPersonName = function (p) { console.log(p.name); };
var bob = new Person("Bob Smith", 30);
printPersonName(bob);   // Bob Smith

// if you want to add a method to a class such that all members of the class can use it, we use the following syntax to extend the prototype:
function Dog(breed) {
  this.breed = breed;
}
var buddy = new Dog("golden Retriever");
Dog.prototype.bark = function() { console.log("Woof"); };
buddy.bark();
var snoopy = new Dog("Beagle");
snoopy.bark();

// By default, all classes inherit directly from Object, unless we change the class's prototype
function Penguin(name) {
    this.name = name;
    this.numLegs = 2;
}
function Emperor(name) { this.name = name;}
Emperor.prototype = new Penguin();  // inheritance
var emperor = new Emperor("aa");
console.log(emperor.numLegs);   // 2

// In JavaScript all properties of an object are automatically public. 
function Person(age) {
   this.age = age;
   var bankBalance = 7500;  // private property
   this.getBalance = function() { return bankBalance; };
}
var john = new Person(30);
console.log(john.bankBalance);  // undefined
var myBalance = john.getBalance();
console.log(myBalance);     // 30

function Person() {
   var bankBalance = 7500;
   this.askTeller = function(pass) {
     if (pass == 1234) return bankBalance;
     else return "Wrong password.";
   };
}
var john = new Person('John','Smith',30);
var myBalance = john.askTeller(1234);    // right password, get balance