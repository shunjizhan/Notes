/* -------------------------------------------------------------------------- 
---------------------------------- Promise ----------------------------------
-------------------------------------------------------------------------- */

/* ---------- create a promise --------- */
var promise = new Promise(function(resolve, reject) {
    // do a thing, possibly async, then…
    if (everythingWorkedWell) {
        resolve("Stuff worked!");
    } else {
        reject(Error("It broke"));
    }
});

// use that promise
promise
  .then(function(result) {
    console.log(result);    // "Stuff worked!"
  }, function(err) {
    console.log(err);       // Error: "It broke"
  });


/* ---------- use promise to create a get function --------- */
function get(url) {
    // Return a new promise.
    return new Promise(function(resolve, reject) {
        // Do the usual XHR stuff
        var req = new XMLHttpRequest();
        req.open('GET', url);

        req.onload = function() {
            // This is called even on 404 etc
            // so check the status
            if (req.status == 200) {
                // Resolve the promise with the response text
                resolve(req.response);
            } else {
                // Otherwise reject with the status text
                // which will hopefully be a meaningful error
                reject(Error(req.statusText));
            }
        };

        // Handle network errors
        req.onerror = function() {
            reject(Error("Network Error"));
        };

        // Make the request
        req.send();
    });
}

// use it
get('story.json')
.then(function(response) {
    return JSON.parse(response);
}, function(error) {
    console.error("Failed!", error);
});

// make it a function
function getJSON(url) {
  return get(url).then(JSON.parse);
}

/* ---------- chain of then() function --------- */
var promise = new Promise(function(resolve, reject) {
    resolve(1);
});
promise.then(function(val) {
    console.log(val); // 1
    return val + 2;
}).then(function(val) {
    console.log(val); // 3
});

/* ---------- wait until all promises are resovled --------- */
var promise1 = Promise.resolve(3);
var promise2 = 42;
var promise3 = new Promise(function(resolve, reject) {
    setTimeout(resolve, 100, 'foo');
});

Promise.all([promise1, promise2, promise3]).then(function(values) {
    console.log(values);    // [3, 42, "foo"]
});


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





/* -------------------------------------------------------------------------- 
---------------------------------- ES7 - ES10 -------------------------------
-------------------------------------------------------------------------- */
/* ---------- Array.prototype.includes() ---------- */
const arr = [1, 3, 5, 2, '8', NaN, -0]
arr.includes(1)     // => true
arr.includes(1, 2)  // => false 该方法的第二个参数表示搜索的起始位置，默认为0
arr.includes('1')   // => false
arr.includes(NaN)   // => true
arr.includes(+0)    // => true

// before ES7 we can do
if (arr.indexOf(el) !== -1) {}
// problem: internally it uses ===, so won't find NaN
[NaN].indexOf(NaN)  // => -1


/* ---------- Async/Await ---------- */
// fetch returns a promise object
fetch('aaa.com')
  .then(res => {
    console.log(res)
    return fetch('bbb.com')
  })
  .then(res => {
    console.log(res)
  })
  .catch(error => {
    console.log(error)
  })

// use async
async function foo() {
  try {
    let res1 = await fetch('aaa.com')
    console.log(res1)
    let res2 = await fetch('bbb.com')
    console.log(res2)
  } catch (err) {
    console.error(err)
  }
}
foo()

// async function returns a promise
async function foo() {
  return 'BTC20000'
}
foo().then(val => console.log(val)) // => BTC20000

// same as
async function foo() {
  return Promise.resolve('BTC20000')
}
foo().then(val => console.log(val)) // => BTC20000


/* ---------- Promise.prototype.finally() ---------- */
// previously in order to implement finally() logic, we need to repeat same code in both then() and catch()
fetch('https://www.google.com')
  .then((response) => {
    console.log(response.status);
  })
  .catch((error) => { 
    console.log(error);
  })
  .finally(() => { 
    document.querySelector('#spinner').style.display = 'none';
  });


/* ---------- Object.values()，Object.entries() ---------- */
const obj = { foo: 'bar', baz: 42 };
Object.values(obj)  // => ["bar", 42]
const obj = { 100: 'a', 2: 'b', 7: 'c' };
Object.values(obj)  // => ["b", "c", "a"]
// note from above that if key is a number, then the result order is from small key number to large

const obj = { foo: 'bar', baz: 42 };
Object.entries(obj) // => [ ["foo", "bar"], ["baz", 42] ]
const obj = { 10: 'xxx', 1: 'yyy', 3: 'zzz' };
Object.entries(obj);    // => [['1', 'yyy'], ['3', 'zzz'], ['10': 'xxx']]


/* ---------- for await of ---------- */
// if we have 3 asnyc tasks, and want their results in order

// for of won't itereate them in the correct order
function wait(time) {
  return new Promise(function (resolve, reject) {
    setTimeout(function() {
      resolve(time)
    }, time)
  })
}
async function test() {
  let arr = [wait(2000), wait(100), wait(3000)]
  for (let item of arr) {
    console.log(Date.now(), item.then(console.log))
  }
}
test()
/* ==>
    1578088713192 Promise {<pending>}
    1578088713192 Promise {<pending>}
    1578088713192 Promise {<pending>}
    100
    2000
    3000
*/

// for await of won't continue iterating until last promise changed state
// this is what we want
function wait(time) {
  return new Promise(function (resolve, reject) {
    setTimeout(function() {
      resolve(time)
    }, time)
  })
}
async function test() {
  let arr = [wait(2000), wait(100), wait(3000)]
  for await (let item of arr) {
    console.log(Date.now(), item)
  }
}
test()
/* ==>
    1578088826764 2000
    1578088826765 100
    1578088827765 3000
*/


/* ---------- Object Spread ---------- */
// ES6
const arr1 = [10, 20, 30];
const copy = [...arr1]; // 复制
console.log(copy);      // => [10, 20, 30]
const arr2 = [40, 50];
const merge = [...arr1, ...arr2]; // 合并
console.log(merge);     // => [10, 20, 30, 40, 50]
console.log(Math.max(...arr));    // => 30 拆解

// ES9
const input = {
  a: 1,
  b: 2,
  c: 1
}
const output = {
  ...input,
  c: 3               // if there is same key, last one will stay
}
console.log(output)  // => { a: 1, b: 2, c: 3 }

// spread operator is shallow copy
const obj = { x: { y: 10 } };
const copy1 = { ...obj };    
const copy2 = { ...obj }; 
obj.x.y='xxx'
console.log(copy1, copy2) // x: { y: "xxx" }   x: { y: "xxx" }
console.log(copy1.x === copy2.x);    // => true

// rest spread (can only be put at last)
const input = {
  a: 1,
  b: 2,
  c: 3
}
let { a, ...rest } = input
console.log(a, rest) // 1  { b: 2, c: 3 }



/* ---------- Array.prototype.flat() ---------- */
newArray = arr.flat(depth)  // depth deault to 1 

const nums = [1, 2, [3, 4, [5, 6]]]
console.log(nums.flat())   // => [1, 2, 3, 4, [5, 6]]
console.log(nums.flat(2))  // => [1, 2, 3, 4, 5, 6]


/* ---------- Object.fromEntries() ---------- */
const object = { x: 23, y:24 };
const entries = Object.entries(object); // [['x', 23], ['y', 24]]
const result = Object.fromEntries(entries); // { x: 23, y: 24 }

// example: get all pairs that has value > 21
const obj = {
  a: 21,
  b: 22,
  c: 23
}
const res = Object.fromEntries(
    Object.entries(obj).filter(([k, v]) => v > 21)
);


/* ---------- try...catch ---------- */
try {
    // ......
} catch {     // now catch doesn't have to be catch(err), can ignore the param
    // ......
}


/* ---------- BigInt ---------- */
// JS can't preserve precision for n > 2^53
// It also can't denote n > 2^1024, which will return Infinity
Math.pow(2, 53) === Math.pow(2, 53) + 1   // => true
Math.pow(2, 1024)                         // => Infinity

// Bitint can precisely denote any big int, just add 'n' to an int
const aNumber = 111;
const aBigInt = BigInt(aNumber);
aBigInt === 111n // true
typeof aBigInt === 'bigint' // true
typeof 111 // "number"
typeof 111n // "bigint"

/* now there are 7 primitives type in JS
  - Boolean
  - String
  - Number
  - Null (no value)
  - Undefined (a declared variable but hasn’t been given a value)
  - Symbol (new in ES6, a unique value that's not equal to any other value)
  - BigInt (new in ES10)
*/


/* ---------- Function.prototype.toString() ---------- */
// can print the whole source code

function sum(a, b) {
  return a + b;
}
console.log(sum.toString());
// function sum(a, b) {
//  return a + b;
// }







