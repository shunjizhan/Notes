# JavaScript Examples
These are some examples/tricks/knowledges that I learned during everyday coding.

### add spaces to html
usually html doesn't preserve space, to manually add, we can use:
```html
&nbsp; (1 space)
&ensp; (2 spaces)
&emsp; (4 spaces)
```

### destructing from import
We couldn't use destruct from import, which will get error `ES2015 named imports do not destructure. Use another statement for destructuring after the import`.
```js
// this will throw error
import { a: { b } } from 'x';

// this will work
import { a } from 'x';
const { b } = a; 

```

### reverse array of object
```js
// this won't work (why???)
let newArray = arrayOfObj.reverse();
// this will work (why???)
let newArray = [...arrayOfObj].reverse();
```

### difference between .fail() and .catch()
catch will return a new (resolved) promise, whereas fail will return the original promise.
note that catch(fn) is an alias of then(null, fn).
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


### Dispatch a function
Instead of dispatching an action, if we are using thunk middleware, we can also dispatch a function that takes dispatch as a parameters, so that we can do more complex logic such as ajax and promise. ([example](https://redux.js.org/api/applymiddleware/#example-using-thunk-middleware-for-async-actions))
```js
const funcAsAction = dispatch => {
  dispatch(actionA());
  someAjaxCall().then(
    res => dispatch(actionB(res)),
    err => dispatch(actionC(err))
  )
}

store.dispatch(funcAsAction);
```

### Conditionally adding keys to object
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

### Get full and relative path
```js
console.log(window.location.pathname);  // => "/path"
console.log(window.location.href);      // => "https://example.com/path"
```

### Pass component as props
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

### Props of a functional component
```js
// wrong!!
const Component = (prop1, prop2) => {}

// correct
const Component = ({ prop1, prop2}) => {}

// correct
const Component = (props) => {
    const { prop1, prop2 } = props;
}
```