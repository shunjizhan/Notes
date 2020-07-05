# Questions

## Webpack
- why can't see the exact line of error in console?

## Ruby & Rail
- how is our bundle install install into `vendor/bundle`, it seems to be defined in `lib/version_check.rb:29`, but don't find anywhere that used it in Gemfile. Maybe it was some module that automatically get called?

- why `bundle install` resolving dependencies forever? but `bundle install --local` works? Probably not because downing everything since it never finished

- It seems that how bundle install works is that it first download all `.gemspecs`, and use all these specs to resolve dependeceis, then build the actual gem? Speculated from how the openssl patch did https://gerrit.ikarem.io/c/manage/+/107732

- why after first `bundle install --local`, we don't need --local flag anymore, it will still works. Maybe after first installation the lockfile speficify something?

## Frontend
### why jest spyon must take an object
jest only have this function `jest.spyOn(object, methodName)`, but I was looking for something like `jest.spyOn(methodName)` directly, but it doesn't exist.