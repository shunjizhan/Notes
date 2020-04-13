# Knowledges
These are some knowledge that is great to keep in mind.


## Tips
- MacOS will not load `.bashrc` by default, so use `.bash_profile` <br>
- VScode user settings: `~/Library/Application Support/Code/User` <br>
- Sublime user settings: `~/Library/Application Support/Sublime Text 3/Packages/User` <br>
- When do `bundle [something]`, Gemfile was always loaded <br>
- Compare two tags/branchs/commits in github: `https://github.com/some_repo/compare/tag1...tag2` <br>


## Ruby & Rails
### How Does the ruby versions and the version manager works?
a couple importance env variables used by RVM:
- `GEM_HOME`     = /home/ji/.rvm/gems/ruby-2.5.7
- `GEM_PATH`     = /home/ji/.rvm/gems/ruby-2.5.7:/home/ji/.rvm/gems/ruby-2.5.7@global
- `MY_RUBY_HOME` = /home/ji/.rvm/rubies/ruby-2.5.7      # ruby binary is in here: [here]/bin/ruby

for Thruby, it uses a env variable $RUBIES to find the ruby binary, so the migrate from RVM to Thruby, do `RUBIES+=(~/.rvm/rubies/*)`, which is to add the path for RVM installed rubies for Thuruby to find. <br>

Actually, the Ruby version management tools are just wrappers that manage path to ruby binary and gems.

### How does `bundle install --local` works
It fetches gems from `vendor/cache`, (I speculate) then the "install" is to copy such gem to the correct path, according to the env variables. <br>

if `Gemfile.lock` is present, we can do `bundle install` direclty without the --local flag, (I specualte) the lock file is actually the resolved dependencies, which bypass the forever "resolving dependencies" process in bundle install.


## Frontend
### How to align text vertically center in a DIV
just do 
```scss
line-height: $height-of-parent;
```

### How to include external files in Create-React-App
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

### Run a npm packge binary from CLI and package.json
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

### Import a module from npm package
Suppose `jscodeshift` is a package in `node_modules`, and `jscodeshift/dist/testUtils` is a file that export `defineTest()`, then we can do something like
```js
import { defineTest } from "jscodeshift/dist/testUtils";
````

### Props of a functional component
```jsx
// wrong!!
const Component = (prop1, prop2) => {}

// correct
const Component = ({ prop1, prop2}) => {}

// correct
const Component = (props) => {
    const { prop1, prop2 } = props;
}
```

### Pass component as props
1) pass as an instantiated prop
```jsx
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
```jsx
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
```jsx
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

### Get full and relative path
```js
console.log(window.location.pathname);  // => "/path"
console.log(window.location.href);      // => "https://example.com/path"
```

### Dumb global variable
In JS, if in a file some variable `x` is used but not defined, maybe some dumb guy defined it globally, try global search `window.x`.

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

### run jest on a particular test
`yarn run jest ... -t 'test name'`


## Other
### can't checkout some file
In my particular case, a file's state is 'both modified', so when I do `git checkout` it didn't work, saying 'error: path 'some/path' is unmerged'.

Solution:
`git reset file`
`git checkout file`

### cd into a folder containing whitespace
`cd ~/Library/Application Support` won't work, instead we can do 
- `cd ./Library/Application\ Support` or 
- `cd "./Library/Application Support"/`

### find source of command
sometimes if we can type something on terminal, but it is not an alias, instead it may be a shell defined function, so `which command_name` will return nothing. Instead we can use a more generic command `type command_name`, this will show not only alias but shell defined functions.

### mv all files inclusing hidden files
if we do `mv from/* /to`, this won't move any hidden files. To move all files including hidden files, we can manually specify hidden files: `mv from/* from.* /to`


