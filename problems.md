# Problem Solved
This is some problems I solved, just to record the problem, analysis, solution, and lesson learned, so that in the future if similar problems occur, I will have record and ideas how to solve them.

## When bundel install, resolve dependencies forever. @2019.11.18
Analysis: this is because `bundle install` by default will try fetching everything remotely, but we already have cache which can speed it up

Solution: use `bundle install --local`, so it will use gem cach. If we do `bundle install --verbose`, we can see the results:

```
0:  zeus (0.15.14) from /home/ji/co/manage/vendor/bundle/ruby/2.5.0/specifications/zeus-0.15.14.gemspec
Updating files in vendor/cache
......
......

``` 

## After remove the source code for a gem X, then `bundle install`, the bundle will still thought that gem X was installed. @2019.11.18
Analysis: I was going in the right direction by thinking about maybe bundle install doesn't look for the actual source code installed, but instead use some matadata or cache to determine if X exist. I tried to remove the the cache for X in 1`$GEM_HOME/cache`, but still didn't work. Then I `find . | grep X` in `$GEM_HOME`, and found that there is a `X.gemspec` somewhere, after removing which the `bundle install` will know the gem doesn't exist anymore.

Lesson: when try to find information related to X, try to grep X around, instead of try thinking by logic.

## when do bundle install, even ruby version is correct, the bundler can't find the correct ruby version. @2019.11.19
This was because bundler has different env varaibels, which can be shown by `bundler env`. It seems that when I do `chruby 2.5.7`, it only switch ruby version, but didn't update the dependencies, so the bundler env was not updated. Instead, use `chruby Ruby-2.5.7`, which updated all environments too.

## Enzyme wrapper won't update the props @2019.12.3
Problem: after simualte some change event, I expect the children under Formsy to have updated props, however it doesn't, the props is always the default one.

Analysis: at first I thought that was because Formsy wrapper didn't pass the correct props, however, it turned out that I assigned the children component before the change event, so the updarted props didn't get pass to it. I was surprised that the component variable doiesn't store a reference, but some sort of snapshot. So the solution would be, don't assign the children component until after the change event fires.
```
// won't work
multiLineTextInput = wrapper.find("MultiLineTextInput");
textarea.simulate("change", { target: { value: newValue } });

// works
textarea.simulate("change", { target: { value: newValue } });
multiLineTextInput = wrapper.find("MultiLineTextInput");
```

Lesson: one reason that this stuck me for a while was that I kind of assume that the variable stores a reference. So all my thinking and experiment were based on this assumptiion, which made me never able to find the bug. One good way of thoroughly exame the logic is "from the beginning", don't stuch in one place, just go through the whole code and even these lines that seems to be "impossible to be wrong".