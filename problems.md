# Problem Solved
This is some problems I solved, just to record the problem, analysis, solution, and lesson learned, so that in the future if similar problems occur, I will have record and ideas how to solve them.

## When bundel install, resolve dependencies forever
analysis: this is because `bundle install` by default will try fetching everything remotely, but we already have cache which can speed it up

solution: use `bundle install --local`, so it will use cache in /vendor/cache, and is super fast.

## After remove the source code for a gem X, then `bundle install`, the bundle will still thought that gem X was installed
analysis: I was going in the right direction by thinking about maybe bundle install doesn't look for the actual source code installed, but instead use some matadata or cache to determine if X exist. I tried to remove the the cache for X in 1`$GEM_HOME/cache`, but still didn't work. Then I `find . | grep X` in `$GEM_HOME`, and found that there is a `X.gemspec` somewhere, after removing which the `bundle install` will know the gem doesn't exist anymore.

lesson: when try to find information related to X, try to grep X around, instead of try thinking by logic.