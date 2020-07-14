# ESNext
These are some useful ES6+ features.


## Array.prototype.includes()
```js
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
```


## Async/Await
compare promise and async
```js
// oldschool promise
fetch('aaa.com')
  .then(res1 => {
    console.log(res1)
    return fetch('bbb.com')
  })
  .then(res2 => {
    console.log(res2)
  })
  .catch(error => {
    console.log(error)
  })

// use async
(async function foo() {
  try {
    let res1 = await fetch('aaa.com')
    console.log(res1)
    let res2 = await fetch('bbb.com')
    console.log(res2)
  } catch (err) {
    console.error(err)
  }
})();
```

```js
async function foo() {
  return 'BTC20000'
}
foo().then(val => console.log(val)) // => BTC20000

/* ---------- equivalent to -------- */
async function foo() {
  return Promise.resolve('BTC20000')
}
foo().then(val => console.log(val)) // => BTC20000
```

## Promise.prototype.finally()
`.finally()` provides a way for code to be run whether the promise was fulfilled successfully or rejected once the Promise has been dealt with.

Previously in order to implement `finally()` logic, we need to repeat same code in both `then()` and `catch()`. 
```js
fetch('https://www.google.com')
  .then(response => {
    console.log(response.status);
  })
  .catch(error => { 
    console.log(error);
  })
  .finally(() => { 
    document.querySelector('#spinner').style.display = 'none';
  });
```


## Object.values()，Object.entries()
```js
const obj = { foo: 'bar', baz: 42 };
Object.values(obj)  // => ["bar", 42]

const obj = { 100: 'a', 2: 'b', 7: 'c' };
Object.values(obj)  // => ["b", "c", "a"]
// note from above that if key is a number, then the result order is from small key number to large

const obj = { foo: 'bar', baz: 42 };
Object.entries(obj) // => [ ["foo", "bar"], ["baz", 42] ]

const obj = { 10: 'xxx', 1: 'yyy', 3: 'zzz' };
Object.entries(obj);    // => [['1', 'yyy'], ['3', 'zzz'], ['10': 'xxx']]
```

## for await of
suppose we have a wait function that will resolve after some given time.
```js
function wait(time) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve(time)
    }, time)
  })
}
```

if we have 3 asnyc tasks, and want their results in order (as order as their index in the array), `for of` won't iterate them in the correct order. It will continue iterating regarless if the promise is resolved.
```js
(async function test() {
  let arr = [wait(2000), wait(100), wait(3000)]
  for (let item of arr) {
    console.log(Date.now(), item.then(console.log))
  }
})();
/* ==>
    1578088713192 Promise {<pending>}
    1578088713192 Promise {<pending>}
    1578088713192 Promise {<pending>}
    100
    2000
    3000
*/
```

`for await of` won't continue iterating until last promise changed state, which is what we want.
```js
(async function test() {
  let arr = [wait(2000), wait(100), wait(3000)]
  for await (let item of arr) {
    console.log(Date.now(), item)
  }
})();
/* ==>
    1578088826764 2000
    1578088826765 100
    1578088827765 3000
*/
```

## spread syntax
`ES6` features
```js
// copy
const arr1 = [10, 20, 30];
const copy = [...arr1];
console.log(copy);      // => [10, 20, 30]

// merge
const arr2 = [40, 50];
const merge = [...arr1, ...arr2];
console.log(merge);     // => [10, 20, 30, 40, 50]

// 拆解
console.log(Math.max(...arr));    // => 30
```

`ES9` features
```js
const input = {
  a: 1,
  b: 2,
  c: 1
}
const output = {
  ...input,
  c: 3               // if there is same key, last one will win
}
console.log(output)  // => { a: 1, b: 2, c: 3 }
```

spread operator is shallow copy
```js
const obj = { x: { y: 10 } };
const copy1 = { ...obj };    
const copy2 = { ...obj }; 
obj.x.y='xxx'
console.log(copy1, copy2) // => x: { y: "xxx" }   x: { y: "xxx" }
console.log(copy1.x === copy2.x);    // => true
```

"rest" spread operator can only be put at last
```js
const input = {
  a: 1,
  b: 2,
  c: 3
}
let { a, ...rest } = input
console.log(a, rest) // => 1  { b: 2, c: 3 }
```


## Array.prototype.flat()
```js
newArray = arr.flat(depth)  // depth deault to 1 

const nums = [1, 2, [3, 4, [5, 6]]]
console.log(nums.flat())   // => [1, 2, 3, 4, [5, 6]]
console.log(nums.flat(2))  // => [1, 2, 3, 4, 5, 6]
```


## Object.fromEntries()
```js
const object = { x: 23, y: 24 };
const entries = Object.entries(object);      // => [['x', 23], ['y', 24]]
const result = Object.fromEntries(entries);  // => { x: 23, y: 24 }
```

example: filter all pairs that has value > 21
```js
const obj = {
  a: 21,
  b: 22,
  c: 23
}
const res = Object.fromEntries(
    Object.entries(obj).filter(([k, v]) => v > 21)
);
```


## try...catch
now catch doesn't have to be catch(err), can ignore the param
```js
try {
    // ......
} catch {    // no param!!
    // ......
}
```


## BigInt
JS can't preserve precision for n > 2^53
It also can't denote n > 2^1024, which will return `Infinity`
```js
Math.pow(2, 53) === Math.pow(2, 53) + 1   // => true
Math.pow(2, 1024)                         // => Infinity
```

`Bitint` can precisely denote any big int, just add 'n' to an int
```js
const aNumber = 111;
const aBigInt = BigInt(aNumber);
aBigInt === 111n            // => true
typeof aBigInt === 'bigint' // => true
typeof 111                  // => "number"
typeof 111n                 // => "bigint"
```

now there are 7 primitives type in JS
- `Boolean`
- `String`
- `Number`
- `Null` (no value)
- `Undefined` (a declared variable but hasn’t been given a value)
- `Symbol` (new in ES6, a unique value that's not equal to any other value)
- `BigInt` (new in ES10)


## Function.prototype.toString()
this is helpful in printing the whole function source code
```js
function sum(a, b) {
  return a + b;
}

console.log(sum.toString());
/* ==>
  function sum(a, b) {
    return a + b;
  }
*/

```