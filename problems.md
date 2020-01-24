# Problem Solved
This is some problems I solved, just to record the problem, analysis, solution, and lesson: learned, so that in the future if similar problems occur, I will have record and ideas how to solve them.

## When bundel install, resolve dependencies forever. @2019.11.18
**Analysis:** this is because `bundle install` by default will try fetching everything remotely, but we already have cache which can speed it up

**Solution:** use `bundle install --local`, so it will use gem cach. If we do `bundle install --verbose`, we can see the results:

```
0:  zeus (0.15.14) from /home/ji/co/manage/vendor/bundle/ruby/2.5.0/specifications/zeus-0.15.14.gemspec
Updating files in vendor/cache
......
``` 

## After remove the source code for a gem X, then `bundle install`, the bundle will still thought that gem X was installed. @2019.11.18
**Analysis:** I was going in the right direction by thinking about maybe bundle install doesn't look for the actual source code installed, but instead use some matadata or cache to determine if X exist. I tried to remove the the cache for X in 1`$GEM_HOME/cache`, but still didn't work. Then I `find . | grep X` in `$GEM_HOME`, and found that there is a `X.gemspec` somewhere, after removing which the `bundle install` will know the gem doesn't exist anymore.

**Lesson:** when try to find information related to X, try to grep X around, instead of try thinking by logic.

## when do bundle install, even ruby version is correct, the bundler can't find the correct ruby version. @2019.11.19
This was because bundler has different env varaibels, which can be shown by `bundler env`. It seems that when I do `chruby 2.5.7`, it only switch ruby version, but didn't update the dependencies, so the bundler env was not updated. Instead, use `chruby Ruby-2.5.7`, which updated all environments too.

## Enzyme wrapper won't update the props @2019.12.3
After simualte some change event, I expect the children under Formsy to have updated props, however it doesn't, the props is always the default one.

**Analysis:** at first I thought that was because Formsy wrapper didn't pass the correct props, however, it turned out that I assigned the children component before the change event, so the updarted props didn't get pass to it. I was surprised that the component variable doiesn't store a reference, but some sort of snapshot. So the solution would be, don't assign the children component until after the change event fires.
```js
// won't work
multiLineTextInput = wrapper.find("MultiLineTextInput");
textarea.simulate("change", { target: { value: newValue } });
```
```js
// works
textarea.simulate("change", { target: { value: newValue } });
multiLineTextInput = wrapper.find("MultiLineTextInput");
```

**Lesson:** one reason that this stuck me for a while was that I kind of assume that the variable stores a reference. So all my thinking and experiment were based on this assumptiion, which made me never able to find the bug. One good way of thoroughly exame the logic is "from the beginning", don't stuch in one place, just go through the whole code and even these lines that seems to be "impossible to be wrong".

**Notes** for html element, it doesn't seem to have this problem, only react component has. Also, I didn't call `unmount` after each, this might also be a solution.

## Ruby2.6 Docker: libraries are missing after installation @2020.01.22
In the Dockerfile we already installed some libraries, such as `make`, however, we still can't find the `make` command when we run shell in container.

**Analysis:** I checked `echo $PATH` and found the path `usr/bin` was included. However `usr/bin/make` is missing. After reinstall `make`, `which make` => `usr/bin/make`. I then tried to put `which make` in the Dockerfile, and it correctly print out `usr/bin/make`.

So the reason is obvious that `usr/bin/make` get installed in the first place, since `which make` => `usr/bin/make` in the Dockerfile. But it got removed somehow.

**Solution:** After more carefully inspect the Dockerfile there is a line ` apt-get purge -y --auto-remove $buildDeps`, simple reason, but surprisingly I missed it.

**Lesson:** Sometimes the problem is very simple, but I was just not patient enought to look through the Dockerfile to find the line that removed the libraires. 

**Ideal logic:**<br>
Libraries explicitly get installed in the docker file, but it is not present in the container <br> 
=> so it must get removed somewhere <br>
=> so look for a line that remove libraries (search for "remove" or "delete" or "purge" will do it) <br>
=> found it, done!

## Ruby2.6 Docker: cannot build container with jemalloc @2020.01.23
There was already a working ruby2.4 with jemalloc Dockerfile, however, changing version to 2.6 will fail according to this line in Dockerfile 
```ruby
RUN ruby -r rbconfig -e "RbConfig::CONFIG['LIBS'].include?('jemalloc') ? puts('Ruby is compiled with jemalloc') : warn('JEMALLOC IS MISSING FROM RUBY')"
```

**Analysis:** I checked if change version to 2.5 it works, but 2.6 just doesn't work. 

**Solution:** It turns out that in Ruby2.6, jemalloc is in `RbConfig::CONFIG['MAINLIBS']` instead of `RbConfig::CONFIG['LIBS']`

**Lesson:** 
First we need to make sure the test itself is correct! Otherwise all effort will be wasted! 

**Ideal logic:** <br>
try the test commands in different ruby versions to check what has changed:
```ruby
puts RbConfig::CONFIG['LIBS']   # (2.4 & 2.5) => Lib1, Lib2, Lib3, ..., jemalloc 
puts RbConfig::CONFIG['LIBS']   # (2.6)       => Lib1
```
=> many other libs are missing in this variable in Ruby2.6 <br> 
=> it is reasonable to suspect that some libs get saved elsewhere <br>
=> google "Ruby2.6 with jemalloc"
=> find someone complain about similar things
=> find solution under that question













