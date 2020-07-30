# JavaScript Fragment Knowledges
**These are some examples/tricks/knowledges I learned during everyday coding, for JavaScript or frontend in general.**
**They are not that systematic, but covers a wide range of topics so can be very useful.**


## console.log tricks
instead of doing
```js
console.log('----- here -----')
console.log('something')
console.log('----------')
```
we can do it more "console" way
```js
console.group('here')
console.log('something')
console.groupEnd()
```

timing in console
```js
console.time()
// so something
console.timeEnd()
```


## print the object in that snapshot
if we do this, it will print the latest (future) value of object, sounds like **quatum physics**, where somehow history and future are connected!!
```js
let obj = { a: 1 };
console.log(obj);   // => 2
obj.a = 2;
```
to print out the actual value of `obj` in that snapshot, we can do
```js
let obj = { a: 1 };
console.table(obj);   // => print a table showing a: 1
obj.a = 2;
```



## replace() on all occurance
`g` in regex is for global search, meaning it'll match all occurrences.

if we want to replace all `white space` with `_`, `.replace(' ', '_')` will only replace the first occurance. We should do a regex specifying global match `.replace(/ /g, '_')`.


## mouse events
`hover` is not an native event, jqeury `.hover()` actually triggers `mouseenter`/`mouseleave` events.

`mouseover`/`mouseout` events are similar, but one difference is that, `mouseout` will be triggerred when the pointer moves from an element to its descendant, such as from `#parent` to `#child` in the below code. But `mouseleave` won't.
```html
<div id="parent">
  <div id="child">...</div>
</div>
```


## beforeEach() execution order
in jest outer `beforeEach()` will run first.
```js
describe('outer', () => {
  beforeEach(() => console.log('outer beforeEach()'));

  describe('inner', () => {
    beforeEach(() => console.log('inner beforeEach()'));

    it('print out execution order', () => {});
  });
});

/* =>
  outer beforeEach()
  inner beforeEach()
*/
```


## jest spyOn
1) spy on an `object`
```js
const obj = {
  func: x => (true)
};
const spy = jest.spyOn(obj, "func");
```

2) spy on a `class`
```js
class Foo {
  func() {}
}
 
// THROWS ERROR. Foo has no "func" method. Only an instance of Foo has "func".
const nope = jest.spyOn(Foo, "func");

// Any call to "func" will trigger this spy.
const fooSpy = jest.spyOn(Foo.prototype, "func");

// Any call fooInstance makes to "func" will trigger this spy.
const fooInstance = new Foo();
const fooInstanceSpy = jest.spyOn(fooInstance, "func");

```

3) spy on `React.Component instance`
```js
const component = shallow(<App />);
// component.instance() // => { func: f(), render: f(), ... }
const spy = jest.spyOn(component.instance(), "func");
```

4) spy on `React.Component.prototype`
```js
// App.prototype // => { func: f(), render: f(), .. }
// Any call to "func" from any instance of App will trigger this spy.
const spy = jest.spyOn(App.prototype, "func");
```


## how to align text vertically center in a DIV
just do 
```scss
line-height: $height-of-parent;
```


## how to include external files in Create-React-App
put 
```js
<script src='lib/some-library.min.js'></script>
``` 
in `public/index.html`, where `lib/` folder is in `public/`, since create-react-app only serves all the assets in `public/` but not other places such as `src/`.

Similarly, if there are some img in `src/`, this won't work
```html
<img src="../../img/goku.jpg" />
```
instead we need to do 
```html
<img src={ require("../../img/goku.jpg") } />
```


## run a npm packge binary from CLI and package.json
Usually the binary is in`node_modules/.bin`, it is hard to run because it involves dealing with $PATH stuff, which is really annoying. Now we can use `npx <command>`, which will take care of $PATH automatically. For example 
```
$ npm i -D webpack
$ npx webpack ...
```
On the other hand, scripts in `package.json` actually have access to npm libraries, so we can do `npm run compile` if we add this to `package.json`
```json
{
  "scripts": {
    "compile": "webpack"
  },
}
```


## import a module from npm package
Suppose `jscodeshift` is a package in `node_modules`, and `jscodeshift/dist/testUtils` is a file that export `defineTest()`, then we can do something like
```js
import { defineTest } from "jscodeshift/dist/testUtils";
```


## run jest on a particular test
`yarn run jest ... -t 'test name'`


## JS object key type
we can't have integer keys. JS will convert the integer to a string. It is not recommended to use int as key, since this could cause problem due to JS rounding stuff.
```js
const test = {
  100: 'BTC',
};
test[100]   // => BTC
test['100'] // => BTC
typeof Object.keys(test)[0]   // => string
```


## Coercion to Boolean Values
usually we can use `!!` to coercion variable to Boolean Values
```js
!!'hello'  // => true
!!{}       // => true
!![]       // => true
!!1       // => true

!!''       // => false
!!null     // => false
!!undefined // => false
!!0        // => false
```


## short circuit evaluation
`A && B` returns the value A if A can be coerced into false; otherwise, it returns B.
```js
true && 'hello'   // => hello
'hello' && true   // => true
'hello' && false  // => false
'hello' && null  // => null
null && 'hello'  // => null
```

`A || B` returns the value A if A can be coerced into true; otherwise, it returns B.
```js
true || 'hello'   // => true
'hello' || true   // => hello
null || false  // => false
false || 'hello'  // => hello
```

short circuit evaluation examples
```js
const x = y || 'defaultValue';
const x = someCondition && 'BTC';
someCondition && doSth();
```


## console.log a function definition
This could sometimes be helpful in debugging
```js
console.log(func.toString());
```


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
