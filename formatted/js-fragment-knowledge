# JavaScript Fragment Knowledges
These are some examples/tricks/knowledges I learned during everyday coding.
They are not that systematic, but covers a wide range of topics so can be very useful.


## dynamically generate React tags
method 1: use `React.createElement`
```js
const elem = React.createElement(
  `h${level}`,
  { className: 'someHeading' },
  children,
);
```

method 2: use dynamic tag
```js
const TagName = `h${level}`;
const elem = (
  <TagName
    className='someHeading'
  >
    { children }
  </TagName>
);
```


## check equality
`===`: strict equality: comparing both the type and the value.
```js
5 === 5                         // true
'hello world' === 'hello world' // true (Both Strings, equal values)
true === true                   // true (Both Booleans, equal values)

77 === '77'                     // false (Number v. String)
'cat' === 'dog'                 // false (Both are Strings, but have different values)
false === 0                     // false (Different type and different value)
```

`==`: loose equality: first performs type coercion (two values are compared only after attempting to convert them into a common type)
```js
77 == '77' // true
false == 0 // true
```

falsy values
- `false` — boolean false
- `0` — number zero
- `“”` — empty string
- `null`
- `undefined`
- `NaN` — Not A Number

```js
// When loose comparing { false, 0, "" }, they will always be equal! That’s because these values will all coerce into a false boolean.
false == 0              // true
0 == ""                 // true
"" == false             // true

// When comparing null and undefined, they are only equal to themselves and each other:
null == null            // true
undefined == undefined  // true
null == undefined       // true

// If we try to compare { null, undefined } to any other value, it will return false.
null == 0               // false
null == ''              // false
null == false           // false
undefined == 0          // false
undefined == ''         // false
undefined == false      // false

// NaN is not equivalent to anything. Even cooler, not even itself!
NaN == null             // false
NaN == undefined        // false
NaN == NaN              // false
```

How JS compare:
- Primitives like strings and numbers are compared by their value.
- Objects like arrays, dates, and plain objects are compared by their reference (memory location).

```js
o1 = {};
o2 = {};
o3 = o1;
o1 == o2    // false, not the same reference
o1 === o2   // false, same type but different value (reference)
o1 == o3    // true, they are exactly the same obj
o1 === o3   // true, they are exactly the same obj
```


## use named parameter in function definition
```js
const test = ({
  paramWithDefaultValue = 'BTC',
  param2,
} = {}) => console.log(paramWithDefaultValue, ' | ', param2);

console.log(test());    // => BTC | undefined
console.log(test({
  paramWithDefaultValue: 'ATOM',
}));                    // => ATOM | undefined
console.log(test({
  param2: '20000',
}));                    // => BTC | 20000
console.log(test({
  paramWithDefaultValue: 'ATOM',
  param2: '100',
}));                    // => ATOM | 100
```


## add spaces to html
usually html doesn't preserve space, to manually add, we can use:
```html
&nbsp; (1 space)
&ensp; (2 spaces)
&emsp; (4 spaces)
```


## destructing from import
We couldn't use destruct from import, which will get error `ES2015 named imports do not destructure. Use another statement for destructuring after the import`.
```js
// this will throw error
import { a: { b } } from 'x';

// this will work
import { a } from 'x';
const { b } = a; 

```


## reverse array of object
```js
// this won't work (why???)
let newArray = arrayOfObj.reverse();
// this will work (why???)
let newArray = [...arrayOfObj].reverse();
```


## difference between .fail() and .catch()
`.catch()` will return a new (resolved) promise, whereas `.fail()` will return the original promise.
Note that `catch(fn)` is an alias of `then(null, fn)`.
```js
// This will only output "fail"
$.Deferred()
  .reject(new Error("something went wrong"))
  .fail(function() {
    console.log("fail");
  })
  .then(function() {
    console.log("then after fail");
  })

// This will output "catch" and "then after catch"
$.Deferred()
  .reject(new Error("something went wrong"))
  .catch(function() {
    console.log("catch");
  })
  .then(function() {
    console.log("then after catch");
  })
```


## dispatch a function
Instead of dispatching an action, if we are using thunk middleware, we can also dispatch a function that takes dispatch as a parameters, so that we can do more complex logic such as ajax and promise. ([example](https://redux.js.org/api/applymiddleware/#example-using-thunk-middleware-for-async-actions))
```js
const funcAsAction = dispatch => {
  dispatch(actionA());
  return someAjaxCall().then(
    res => dispatch(actionB(res)),
    err => dispatch(actionC(err))
  )
}

store.dispatch(funcAsAction);
```


## conditionally adding keys to object
```js
const object = {};
if (sth.x) {
  object.x = sth.x;
}

// same as
const { x } = sth;
const object = {
  ...(x && { x }),
};

// this also works, since `x && { x }` will be first evaluated as Logical Expression
// then the whole this is evaluated as a SpreadElement
const { x } = sth;
const object = {
  ...x && { x },
};
```


## get full and relative path
```js
console.log(window.location.pathname);  // => "/path"
console.log(window.location.href);      // => "https://example.com/path"
```


## pass component as props
1) pass as an instantiated prop
```js
const Messege = ({ value }) => (<span>{ value }</span>);
const messege = <Messege value='BTC20000'/>;

const App = ({ message }) => (
  <div>Hello { message }</div>
);

ReactDOM.render(
  <App message={ messege } />,
  document.getElementById("root")
)
```

2) pass as a react block directly
```js
const messege = (<span>BTC20000</span>);

const App = ({ message }) => (
  <div>Hello { message }</div>
);

ReactDOM.render(
  <App message={ messege } />,
  document.getElementById("root")
);
```

3) pass as children
```js
const Messege = ({ value }) => (<span>{ value }</span>);

const App = (props) => (
  <div>Hello { props.children }</div>
);

ReactDOM.render(
  <App>
     <Messege value='BTC20000'/>
  </App>,
  document.getElementById("root")
)
```


## props of a functional component
```js
// wrong!!
const Component = (prop1, prop2) => {}

// correct
const Component = ({ prop1, prop2 }) => {}

// correct
const Component = (props) => {
  const { prop1, prop2 } = props;
}
```
