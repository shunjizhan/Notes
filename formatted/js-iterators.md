# Iterators and Generators
**These are some systematic knowledge/examples of JS iterators and generators**


## basic iterator concepts
An `iterable` is a data structure that makes its elements accessible to the public by implementing a method whose key is `Symbol.iterator`. That method is a factory for iterators. That is, it will create `iterators`. An `iterator` is a pointer for traversing the elements of a data structure.
```ts
const iterable = {
  [Symbol.iterator]() {
    let step = 0;
    const iterator = {
      next() {
        step++;

        switch (step) {
          case 1: return { value: 'this', done: false };
          case 2: return { value: 'is', done: false };
          case 3: return { value: 'iterable', done: false };
          default: return { value: undefined, done: true };
        }
      }
    };

    return iterator;
  }
};

let iterator = iterable[Symbol.iterator]();
iterator.next();    // => { value: "this", done: false }
iterator.next();    // => { value: "is", done: false }
iterator.next();    // => { value: "iterable", done: false }
iterator.next();    // => { value: undefined, done: true }
```


## iterables
- `Arrays` and `TypedArrays`
- `Strings` — iterate over each character or Unicode code-points.
- `Maps` — iterates over its key-value pairs
- `Sets` — iterates over their elements
- `arguments` — An array-like special variable in functions
- `DOM elements` (Work in Progress)


## iterables examples
###`for-of` loops
The `for-of` loops takes an `iterable`, and creates its `iterator`. It keeps on calling the `next()` until done is true.


### destructuring of arrays
```ts
const array = ['a', 'b', 'c', 'd', 'e'];
const [first, ,third, ,last] = array;

/* ---------- is equivalent to ---------- */

const array = ['a', 'b', 'c', 'd', 'e'];
const iterator = array[Symbol.iterator]();
const first = iterator.next().value
iterator.next().value   // Since it was skipped, so it's not assigned
const third = iterator.next().value
iterator.next().value   // Since it was skipped, so it's not assigned
const last = iterator.next().value
```


### the spread operator (...)
```ts
const array = ['a', 'b', 'c', 'd', 'e'];
const newArray = [1, ...array, 2, 3];

/* ---------- is equivalent to ---------- */

const array = ['a', 'b', 'c', 'd', 'e'];
const iterator = array[Symbol.iterator]();
const newArray = [1];
for (
  let nextValue = iterator.next();
  nextValue.done !== true;
  nextValue = iterator.next()
) {
  newArray.push(nextValue.value);
}
newArray.push(2)
newArray.push(3)
```


### Maps and Sets
- The constructor of a `Map` turns an `iterable` over `[key, value]` pairs into a Map.
- The constructor of a `Set` turns an `iterable` over elements into a Set.


## basic generator concepts
ES6 introduced a new way of working with functions and `iterators` in the form of `Generators` (or generator functions). A `generator` is a function that can stop midway and then continue from where it stopped. In short, a `generator` appears to be a function but it behaves like an `iterator`. Instead of returning any value, a generator function always returns a generator object

- `Generators` are a special class of functions that simplify the task of writing iterators.
- A `generator` is a function that produces a sequence of results instead of a single value, i.e you generate ​a series of values.

```ts
function * generatorFunc() {
  console.log('1');
  yield '2';
  console.log('3');  
  yield '4';
}
const generatorObject = generatorFunction();
console.log(generatorObject.next().value);    // => 1 2
console.log(generatorObject.next().value);    // => 3 4
console.log(generatorObject.next().value);    // => undefined
```

We can also return from a `generator`. However, return sets the done property to true after which the `generator` cannot generate any more values.
```ts
function *  generatorFunc() {
  yield 'a';
  return 'b';   // Generator ends here.
  yield 'a';    // Will never be executed. 
}
```


## use of generators
We can largely simply the iterable seen before:
```ts
const iterable = {
  [Symbol.iterator]() {
    let step = 0;
    const iterator = {
      next() {
        step++;

        switch (step) {
          case 1: return { value: 'this', done: false };
          case 2: return { value: 'is', done: false };
          case 3: return { value: 'iterable', done: false };
          default: return { value: undefined, done: true };
        }
      }
    };

    return iterator;
  }
};

for (const val of iterable) {
  console.log(val);
  // This
  // is 
  // iterable.
}

/* ---------- is equivalent to ---------- */

function * iterable() {
  yield 'This';
  yield 'is';
  yield 'iterable.'
}

for (const val of iterable()) {
  console.log(val);
  // This
  // is 
  // iterable.
}
```

It’s possible to create `generators` that never end, for example an `infinite data streams of power series`
```ts
function * powerSeries(base, power) {
  while(true) {
    yield Math.pow(base, power);
    power++;
  }
}
const ps = powerSeries(2, 2);
console.log(ps.next().value);  // => 2 ^ 2 = 4
console.log(ps.next().value);  // => 2 ^ 3 = 8
......
```


## advantages of generators
- **lazy evaluation**: As seen with `infinite data streams of power series` example, it is possible only because of lazy evaluation. `Lazy Evaluation` is an evaluation model which delays the evaluation of an expression until its value is needed. That is, if we don’t need the value, it won’t exist. It is calculated as we demand it.
- **memory efficient**: A direct consequence of Lazy Evaluation is that generators are memory efficient. We generate only the values that are needed. With normal functions, we needed to pre-generate all the values and keep them around in case we use them later.


## references
https://codeburst.io/a-simple-guide-to-es6-iterators-in-javascript-with-examples-189d052c3d8e
https://codeburst.io/understanding-generators-in-es6-javascript-with-examples-6728834016d5
https://codeburst.io/javascript-double-equals-vs-triple-equals-61d4ce5a121a

