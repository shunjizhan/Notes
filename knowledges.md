# Knowledges
These are some knowledge that is great to keep in mind.


## Tips
- MacOS will not load `.bashrc` by default, so use `.bash_profile`
- VScode user settings: `~/Library/Application Support/Code/User`


## Discovery
- when do `bundle [something]`, Gemfile was always loaded.


## Ruby & Rails
### How Does the ruby versions and the version manager works?
a couple importance env variables used by RVM:
- `GEM_HOME`     = /home/ji/.rvm/gems/ruby-2.5.7
- `GEM_PATH`     = /home/ji/.rvm/gems/ruby-2.5.7:/home/ji/.rvm/gems/ruby-2.5.7@global
- `MY_RUBY_HOME` = /home/ji/.rvm/rubies/ruby-2.5.7      # ruby binary is in here: [here]/bin/ruby

for Thruby, it uses a env variable $RUBIES to find the ruby binary, so the migrate from RVM to Thruby, do `RUBIES+=(~/.rvm/rubies/*)`, which is to add the path for RVM installed rubies for Thuruby to find.

Actually, the Ruby version management tools are just wrappers that manage path to ruby binary and gems.

### How does `bundle install --local` works
It fetches gems from `vendor/cache`, (I speculate) then the "install" is to copy such gem to the correct path, according to the env variables. 

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


## Other
### can't checkout some file
In my particular case, a file's state is 'both modified', so when I do `git checkout` it didn't work, saying 'error: path 'some/path' is unmerged'.

Solution:
`git reset file`
`git checkout file`
