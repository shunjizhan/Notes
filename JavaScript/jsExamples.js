/* -------------------------------------------------------------------------- 
---------------------------------- Promise ----------------------------------
-------------------------------------------------------------------------- */


/* ---------- 3 different ways to implement a ticker --------- */
class Ticker {
    constructor(interval) {
        // ticker functions will call getTime() every interval
        this.interval = interval;
    }

    getTime() {
        /*
            return current timestamp with 1/2 chance,
            return 'hahaha' with 1/2 chance
                                                        */
        const rand = Math.floor(Math.random() * 10);    // 0 - 9
        if (rand >= 5){
            return 'hahaha';
        } else{
            return Math.floor(Date.now() / 1000);
        }
    }

    ticker1() {                 // way 1: setInterval
        setInterval(() => {
            console.log(this.getTime());
        }, this.interval);
    }   

    ticker2() {                 // way 2: setTimeout
        setTimeout(() => {
            console.log(this.getTime());
            this.ticker2();
        }, this.interval);
    }

    ticker3() {                 // way3: Promise
        this._print()
        .then(res => { 
            const [msg, data] = res;
            console.log(msg, data);
        }, res => {
            const [error, data] = res;
            console.log(error, data);
        })
        .finally(() => this.ticker3());
    }

    _print() {
        return new Promise((resolve, reject) => {
            setTimeout(() => {
                const data = this.getTime();
                if (data != 'hahaha') {
                    resolve(['success', data]);
                } else {
                    reject(['fail', data]);
                }
            }, this.interval);
        });
    }
}

const t = new Ticker(1000);
t.ticker3();





/* -------------------------------------------------------------------------- 
----------------------------- Throttle function -----------------------------
-------------------------------------------------------------------------- */

/*
implement a throttle function that takes a function and interval,
this function will only output if this interval has passed since last call,
otherwise nothing happends.
*/

// function to be throttled
const f = x => console.log(x);     

// our throttle function
let prevTime = Date.now() - 1000;
const throttle = (f, interval) => {
    return x => {
        let curTime =  Date.now();
        if (curTime - prevTime >= interval) {
            prevTime = curTime;
            f(x);
        }
    };
};

// test cases
const func = throttle(f, 1000);

for (let i = 0; i < 10; i++ ) {
    func('hahaha');     // this will only output once
}

// this will output twice
func('hahaha');
setTimeout(() => func('hahaha'), 1000);





/* -------------------------------------------------------------------------- 
--------------------------------- Interview ---------------------------------
-------------------------------------------------------------------------- */

/* ---------- spacify function ---------- */
spacify('hello world');    // 'h e l l o  w o r l d'
spacify = s => {
    return s.split('').join(' ');
};

// what if we want to do 'hello world'.spacify();
String.prototype.spacify = function() {
    return this.split('').join(' ');
};


/* ---------- hoisted ---------- */
//function declarations are hoisted and class declarations are not: need to first declare class and then access it.
const p = new Rectangle();      // ReferenceError
class Rectangle {}

x();                            // this will work
function x() { console.log(1); }

// similarly variables declarations are hoisted, so we don't have a declare it first
var x = 1;                  // Initialize x
console.log(x + " " + y);   // '1 undefined'
var y = 2;                  // Initialize y

// The above example is implicitly understood as this: 
var x;                      // Declare x
var y;                      // Declare y
// End of the hoisting.
x = 1;                      // Initialize x
console.log(x + " " + y);   // '1 undefined'
y = 2;                      // Initialize y



/* ---------- arguments ---------- */
// our goal is to define a customed log() function

// simple one argument verson: log('hello world')
function log(x) { console.log(x); }

// what if we want to do log('hello', 'world')
// there are two ways
function log() {
    console.log.apply(console, arguments);
}
function log(...args) {
    console.log(...args);
}

// what if we want a prefix so that 
// log('hello', 'world') => '(app) hello world'
function log() {
    //arguments is a pseudo array, and to manipulate it we need to convert it into a standard array first. The common pattern for this is using Array.prototype.slice
    var args = Array.prototype.slice.call(arguments);
    args.unshift('(app)');
    console.log.apply(console, args);
}

/*
by the way, when logging objs,don't use console.log(obj)
use console.log(JSON.parse(JSON.stringify(obj)))
which will ensure we see all values of obj
*/

/* ---------- context ---------- */
var User = {
    count: 1,
    getCount: function() {
        return this.count;
    }
};
console.log(User.getCount());   // 1
var count = User.getCount;
console.log(count());           // undefined, because this's context is window obj

// how to transform so that the second way works?
var count = User.getCount.bind(User);
console.log(count());           // 1
// I think there might be another way to declare getCount using fat arrow
// which is auto bind context. Is it only true in React?

// what is old browswer doesn't has 'bind' function, how to shim it?
Function.prototype.bind = Function.prototype.bind || function(context) {
    var self = this;
    return function() {
        return self.apply(context, arguments);
    };
};


/* ---------- close a window---------- */
// this is not the best way since if the children is clicked, window will still be closed
$('#window').click(closeWindow);

// we should instead check the target of click event, and make sure event wasn't propagated
$('#window').click(function(e) {
    if (e.target == e.currentTarget) {
        closeWindow();
    }
});





/* -------------------------------------------------------------------------- 
----------------------------------- Array -----------------------------------
-------------------------------------------------------------------------- */

/* ---------- Basics ----------*/
// Arrays are a special type of objects. The typeof operator in JavaScript returns "object" for arrays.
const arr = [1, 3, 2, 7, 4];
const sortedArr = arr.sort();
typeof arr;                 // => object  
// 3 ways to recognize array
Array.isArray(fruits);      // => true
fruits instanceof Array     // => true

// two ways of looping  an array
for (let i = 0; i < arr.length; i++ ) {
    console.log(arr[i]);
}
arr.forEach(x => console.log(x));

// two ways of adding element to the end
arr.push(5);
arr[arr.length] = 5;
// Adding elements with high indexes can create undefined "holes" in an array:

// JavaScript does not support arrays with named indexes. 
// If you use named indexes, JavaScript will redefine the array to a standard object. After that, some array methods and properties will produce incorrect results.
var person = [];
person["firstName"] = "John";
person["lastName"] = "Doe";
person["age"] = 46;
var x = person.length;         // person.length will return 0
var y = person[0];             // person[0] will return undefined


/* ---------- Array Methods ----------*/
var res = ["Banana", "Orange"].toString();  // => Banana,Orange
// join() method also joins all array elements into a string. It behaves just like toString(), but in addition you can specify the separator.
var res = ["Banana", "Orange"].join(' * '); // => Banana * Orange

// TO BE CONTINUED...



/* -------------------------------------------------------------------------- 
---------------------------------- Hoisting ---------------------------------
-------------------------------------------------------------------------- */





/* -------------------------------------------------------------------------- 
---------------------------------- Tricks ----------------------------------
-------------------------------------------------------------------------- */
/* ---------- export after declaration ---------- */
const x = "something";
export { x };   // works
export x;       // won't work
// from another file
import { x } from 'file4x';    // import x

/* ---------- replace all ---------- */
var example = "abc abc";
console.log(example.replace(/abc/, "xxx"));  // => "xxx abc"
console.log(example.replace(/abc/g, "xxx")); // => "xxx xxx"

/* ---------- extract unique values ---------- */
var arr = [1, 2, 2, 3, 4, 5, 6, 6, 7, 7, 8, 4, 2, 1]
var unique_arr = [...new Set(entries)];

/* ---------- convert number <=> string ---------- */
var num = 5 + "";
console.log(num);   // => 5
console.log(typeof num);    // => string

the_string = "123";
console.log(+the_string);   // => 123
the_string = "hello";
console.log(+the_string);   // => NaN

/* ---------- shuffle elements from array ---------- */
var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
var sorted_arr = arr.sort(() => (Math.random() - 0.5)); 

/* ---------- flatten multidimensional array ---------- */
var entries = [1, [2, 5], [6, 7], 9];
var flat_entries = [].concat(...entries);

/* ---------- short Circuit Conditionals ---------- */
if (available) { doSomething(); }
available && doSomething()          // shortcut

/* ---------- use length to resize/empty an array ---------- */
var entries = [1, 2, 3, 4, 5, 6, 7];  
console.log(entries.length);    // => 7  
entries.length = 4;  
console.log(entries.length);    // => 4  
console.log(entries);           // => [1, 2, 3, 4]

var entries = [1, 2, 3, 4, 5, 6, 7]; 
console.log(entries.length);    // => 7  
entries.length = 0;   
console.log(entries.length);    // => 0 
console.log(entries);           // => []













