# Knowledges
**These are some knowledge that is great to keep in mind.**


## tips
- MacOS will not load `.bashrc` by default, so use `.bash_profile` <br>
- VScode user settings: `~/Library/Application Support/Code/User` <br>
- Sublime user settings: `~/Library/Application Support/Sublime Text 3/Packages/User` <br>
- When do `bundle [something]`, Gemfile was always loaded <br>
- Compare two tags/branchs/commits in github: `https://github.com/some_repo/compare/tag1...tag2` <br>



## miscellaneous
### can't checkout some file
In my particular case, a file's state is 'both modified', so when I do `git checkout` it didn't work, saying 'error: path 'some/path' is unmerged'.

Solution:
```bash
git reset file
git checkout file
```

### cd into a folder containing whitespace
`cd ~/Library/Application Support` won't work, instead we can do 
- `cd ./Library/Application\ Support` or 
- `cd "./Library/Application Support"/`

### find source of command
sometimes if we can type something on terminal, but it is not an alias, instead it may be a shell defined function, so `which [command_name]` will return nothing. Instead we can use a more generic command `type [command_name]`, this will show not only alias but shell defined functions.

### mv all files inclusing hidden files
if we do `mv from/* /to`, this won't move any hidden files. To move all files including hidden files, we can manually specify hidden files: `mv from/* from.* /to`


## experience
### quickly scroll back to the previous edit position
If we edited some place in the file, and scroll to somewhere else, it might take a long time to find where we previously was if the file is a couple thousand lines long. There are two tricks that can quickly find where we were previously.
1) If you have git tools enabled, just scroll fast and find the green/yellow bar indicating the edit. Finding the extra color is much faster than reading the code line by line trying to figure out which line was just added.
2) Magical commands: `cmd + Z` then `cmd + shift + z`. 


### find out more details about some code
it is very useful to check the commit so that we can know which pieces work together with this code. For example, if I am looking at function `X`, we can check the last commit that changed/added this function `X`, so that we can see a bigger picture.

Also, when search for related code with code piece `X`, try to find more **distinct** feature of `X`. For example, when searching other codes that interact with this html tag,
```html
<button id='xxx' class='someButton'>click</button>
```
searching for 'xxx' will be more efficient than searching 'click' or 'someButton'.

In this second example,
```html
<button class='someButton'>reset feature X</button>
```
the button text 'reset feature X' is very specific. If we see this button on UI, and want to find the source code, searching for 'reset feature X' will likely find it and return only this button. On the other hand, if we search 'someButton', the search result might return multiple buttons, and we need extra time to find this particular one.

### understand how to use a function/component
search the codebase to find other places that uses it, or see its test. It might be hard just by looking at the code to figure out how exactly it works, however, actually usage in the codebase, or tests, will have clear real example of how it is supposed to be used.


### understand some context/concepts
search the confluence doc to see if there is any documentation about it.


### debug idea 1
When a bug happens, think about what has changed, usually if it's not flaky, it must be the change that cause the problem. This can include, code change, version change, env change, etc..

Similar to 控制变量法，we can check the minimum diff of { code, version, env } comparing working and failing version, then the problem has a high change to be in these diff { code, version, env }

For example, the bug fails in ruby 2.6 container, but works for ruby 2.2. The code is the same, so the bug must due to Ruby 2.6 syntax change or container env diff with Ruby2.2 local env.


### debug idea 2
try to find more err msg in logs. For example, either the browser console or the terminal will print out helpful information. Further more, sometimes logs are not logged to console/terminal directly, but write to some local log file (which might be indicated on termial about which file to look for), so we can check the log file for more detailed information.


### empty cache when try something new
There are may weird 'bug' doesn't logically doesn't make sense. Sometimes this is causing by cache so that our newest updated is not loaded. So if something weird happen, first we should make sure the new code is actually running, by deleting old build, empty cache, etc...

For example, once I added some new things and run deploy again, but the new thing didn't show up on the page. I solved it by deleting the old `build/` folder and run the deploy again, then it worked!


### dumb global variable
In JS, if in a file some variable `x` is used but not defined, maybe some dumb guy defined it globally, try global search `window.x`.


## Ruby & Rails
### how Does the ruby versions and the version manager works?
a couple importance env variables used by RVM:
- `GEM_HOME`     = /home/ji/.rvm/gems/ruby-2.5.7
- `GEM_PATH`     = /home/ji/.rvm/gems/ruby-2.5.7:/home/ji/.rvm/gems/ruby-2.5.7@global
- `MY_RUBY_HOME` = /home/ji/.rvm/rubies/ruby-2.5.7      # ruby binary is in here: [here]/bin/ruby

for Thruby, it uses a env variable $RUBIES to find the ruby binary, so the migrate from RVM to Thruby, do `RUBIES+=(~/.rvm/rubies/*)`, which is to add the path for RVM installed rubies for Thuruby to find. <br>

Actually, the Ruby version management tools are just wrappers that manage path to ruby binary and gems.

### how does `bundle install --local` works
It fetches gems from `vendor/cache`, (I speculate) then the "install" is to copy such gem to the correct path, according to the env variables. <br>

if `Gemfile.lock` is present, we can do `bundle install` direclty without the --local flag, (I specualte) the lock file is actually the resolved dependencies, which bypass the long "resolving dependencies" process in bundle install.


## reference
https://javascript.info/mousemove-mouseover-mouseout-mouseenter-mouseleave#mouseout-when-leaving-for-a-child


