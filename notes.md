# Commands

## Ruby & Rails
`rvm list`
`rvm use *[--default] [ruby version number]`
`gem info *[gem package name]`
`gem env`

## Command Line
`printenv`
`ctrl + R`    # search previous command
`find [path] | grep [filename]`     # find filenames that contain [filename] in [path]

## shortcut
`ctrl + shift + K`  # remove whole line










# Problem Solved

## when bundel install, resolve dependencies forever
analysis: this is because `bundle install` by default will try fetching everything remotely, but we already have cache which can speed it up

solution: use `bundle install --local`, so it will use cache in /vendor/cache, and is super fast.

## after remove the source code for a gem X, then `bundle install`, the bundle will still thought that gem X was installed
analysis: I was going in the right direction by thinking about maybe bundle install doesn't look for the actual source code installed, but instead use some matadata or cache to determine if X exist. I tried to remove the the cache for X in 1`$GEM_HOME/cache`, but still didn't work. Then I `find . | grep X` in `$GEM_HOME`, and found that there is a `X.gemspec` somewhere, after removing which the `bundle install` will know the gem doesn't exist anymore.

learned: when try to find information related to X, try to grep X around, instead of try thinking by logic.








# Notes

## small tips
- MacOS will not load `.bashrc` by default, so use `.bash_profile`

## Ruby & Rails
### How Does the ruby versions and the version manager works?
a couple importance env variables used by RVM:
- `GEM_HOME`     = /home/ji/.rvm/gems/ruby-2.5.7
- `GEM_PATH`     = /home/ji/.rvm/gems/ruby-2.5.7:/home/ji/.rvm/gems/ruby-2.5.7@global
- `MY_RUBY_HOME` = /home/ji/.rvm/rubies/ruby-2.5.7      # ruby binary is in here: [here]/bin/ruby

for Thruby, it uses a env variable $RUBIES to find the ruby binary, so the migrate from RVM to Thruby, do `RUBIES+=(~/.rvm/rubies/*)`, which is to add the path for RVM installed rubies for Thuruby to find.

Actually, the Ruby version management tools are just wrappers that manage path to ruby binary and gems.