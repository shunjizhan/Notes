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
### `replace()` on all occurance
`g` in regex is for global search, meaning it'll match all occurrences.

if we want to replace all `white space` with `_`, `.replace(' ', '_')`will only replace the first occurance. We should do a regex specifying global match `.replace(/ /g, '_')`.


### mouse events
`hover` is not an native event, jqeury `.hover()` actually triggers `mouseenter`/`mouseleave` events.

`mouseover`/`mouseout` events are similar, but one difference is that, `mouseout` will be triggerred when the pointer moves from an element to its descendant, such as from `#parent` to `#child` in the below code. But `mouseleave` won't.
```html
<div id="parent">
  <div id="child">...</div>
</div>
```

### `beforeEach()` execution order
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

### jest `spyOn`
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

### Dumb global variable
In JS, if in a file some variable `x` is used but not defined, maybe some dumb guy defined it globally, try global search `window.x`.

### run jest on a particular test
`yarn run jest ... -t 'test name'`

### JS object key type
we can't have integer keys. JavaScript will convert the integer to a string. It is not recommended to use int as key, since this could cause problem due to JS rounding stuff.
```js
const test = {
  100: 'BTC',
};
test[100]   // => BTC
test['100'] // => BTC
typeof Object.keys(test)[0]   // => string
```

### Coercion to Boolean Values
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

### short circuit evaluation
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
````

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

## Experience
### find out more details about some code
it is very useful to check the commit so that we can know which pieces work together with this code. For example, if I am looking at function `X`, we can check the last commit that changed/added this function, so that we can see a bigger picture.

### understand how to use a function/component
search the codebase to find other places that uses it, or see its test. It might be hard just by looking at the code to figure out how exactly it works, however, actually usage in the codebase, or tests, will have clear real example of how it is supposed to be used.

### understand some context/concepts
search the confluence doc to see if there is any documentation about it.

### debug thoughts
When a bug happens, think about what has changed, usually if it's not flaky, it must be the change that cause the problem. This can include, code change, version change, env change, etc..

Similar to 控制变量法，we can check the minimum diff of { code, version, env } comparing working and failing version, then the problem has a high change to be in these diff { code, version, env }

For example, the bug fails in ruby 2.6 container, but works for ruby 2.2. The code is the same, so the bug must due to Ruby 2.6 syntax change or container env diff with Ruby2.2 local env.

## Reference
()[https://javascript.info/mousemove-mouseover-mouseout-mouseenter-mouseleave#mouseout-when-leaving-for-a-child]


