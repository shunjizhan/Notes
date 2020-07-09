# Knowledges
**These are some knowledge that is great to keep in mind.**


## tips
- MacOS will not load `.bashrc` by default, so use `.bash_profile` <br>
- VScode user settings: `~/Library/Application Support/Code/User` <br>
- Sublime user settings: `~/Library/Application Support/Sublime Text 3/Packages/User` <br>
- When do `bundle [something]`, Gemfile was always loaded <br>
- Compare two tags/branchs/commits in github: `https://github.com/some_repo/compare/tag1...tag2` <br>


## How Does the ruby versions and the version manager works?
a couple importance env variables used by RVM:
- `GEM_HOME`     = /home/ji/.rvm/gems/ruby-2.5.7
- `GEM_PATH`     = /home/ji/.rvm/gems/ruby-2.5.7:/home/ji/.rvm/gems/ruby-2.5.7@global
- `MY_RUBY_HOME` = /home/ji/.rvm/rubies/ruby-2.5.7      # ruby binary is in here: [here]/bin/ruby

for Thruby, it uses a env variable $RUBIES to find the ruby binary, so the migrate from RVM to Thruby, do `RUBIES+=(~/.rvm/rubies/*)`, which is to add the path for RVM installed rubies for Thuruby to find. <br>

Actually, the Ruby version management tools are just wrappers that manage path to ruby binary and gems.

## How does `bundle install --local` works
It fetches gems from `vendor/cache`, (I speculate) then the "install" is to copy such gem to the correct path, according to the env variables. <br>

if `Gemfile.lock` is present, we can do `bundle install` direclty without the --local flag, (I specualte) the lock file is actually the resolved dependencies, which bypass the long "resolving dependencies" process in bundle install.


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

# Experience
## find out more details about some code
it is very useful to check the commit so that we can know which pieces work together with this code. For example, if I am looking at function `X`, we can check the last commit that changed/added this function, so that we can see a bigger picture.


## understand how to use a function/component
search the codebase to find other places that uses it, or see its test. It might be hard just by looking at the code to figure out how exactly it works, however, actually usage in the codebase, or tests, will have clear real example of how it is supposed to be used.


## understand some context/concepts
search the confluence doc to see if there is any documentation about it.


## debug tricks
When a bug happens, think about what has changed, usually if it's not flaky, it must be the change that cause the problem. This can include, code change, version change, env change, etc..

Similar to 控制变量法，we can check the minimum diff of { code, version, env } comparing working and failing version, then the problem has a high change to be in these diff { code, version, env }

For example, the bug fails in ruby 2.6 container, but works for ruby 2.2. The code is the same, so the bug must due to Ruby 2.6 syntax change or container env diff with Ruby2.2 local env.


## Dumb global variable
In JS, if in a file some variable `x` is used but not defined, maybe some dumb guy defined it globally, try global search `window.x`.



## Reference
()[https://javascript.info/mousemove-mouseover-mouseout-mouseenter-mouseleave#mouseout-when-leaving-for-a-child]


