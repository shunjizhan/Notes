# Commands
This is my notes of some useful terminal commands & other shortcurs

## Terminal
`printenv`
`ctrl + R`    # search previous command
`find [path] | grep [filename]`     # find filenames that contain [filename] in [path]
`ps -ax`    # list all process
`lsof -i :8888`     # find which process is using some port, such as 8888
`curl http://localhost:8888/v1/chain/get_info`      # get the webpage in terminal
`cat `which bundle` `   # this will first evaluation "which bundle" as a path, and cat this file

`alias be='bundle exec'`    # make an alias
`export BE='bundle exec'`    # make an environment variable. aliases are only a shell feature. Environment variables are inherited by all subprocesses

`ssh something -A`  # -A will forward identity
`alias`     # show all alias


## Ruby & Rails
`rvm list`
`rvm use *[--default] [ruby version number]`
`gem info *[gem package name]`
`gem env`
`gem list`
`bundle exec rspec spec`    # run all tests
`bundle install --force`    # force reinstall all gems


## Shortcut
### Editor
`ctrl + shift + K`  # remove whole line
`ctrl + cmd + G`    # selectAll
`ctrl + Shift + K`  # deleteWholeLine
`DEL`               # delete backwards
`cmd + DEL`         # deleteLine up to cursor
`ctrl + DEL`        # delete the word backwards
`ctrl + BACK`       # delete the word
`cmd + Shift + D`   # duplicate line
`cmd + D`           # add next
`cmd + R`           # search tokens
`cmd + Shift + R`   # search tokens globally
`cmd + L`           # select whole line
`cmd + Shift + P`   # console
`cmd + Shift + H`   # VSCode replace all

### Chrome
`cmd + ⇦ / ⇨`          # go back/front 

### General
`cmd + W`           # close current tab
`cmd + Shift + W`   # close all
`cmd + ,`           # go to options

### MAC
`cmd + Option + D`  # toggle Mac dock
`cmd + shift + G`   # (in finder) go to folder
`ctrl + ⇦ / ⇨`     # switch window
`ctrl + ⇧`         # show windows overview
`cmd + ctrl + q`    # sleep


## Git
### rebase interactively top n commit, @ is shortcut for HEAD
`git rebase -i @~n`

### reset the last changes to staged from commited state 
`git reset --soft HEAD~1`   

### git diff between two branches (of specific file)
`git diff [branch_1]..branch_2 [-- filename]`   
`git diff origin/ruby_2_3..origin/ruby_2_2 -- lib/ostruct.rb`   # example

### squash current commit to previous commit
`git commit --amend`    

### add each chunk interactively
`git add . -p`          

### cherry-pick/checkout some file from local branch/commit
`git cherry-pick/checkout branch/commit -- filename`<br>

### cherry-pick a remote branch
`git fetch remote_url && git cherry-pick FETCH_HEAD` <br>

### clean all untracked files
`git clean -f -d`

### pretty print log
`git log --pretty=oneline --graph --decorate --all`

### git log in time range
`git log --since='FEB 10 2016' --until='FEB 19 2016'`

### list all git alias
`git config -l | grep alias | sed 's/^alias\.//g'`

### seach git log with some keyword
`git log -S"key_word"`

`git clean -f -d`

### hard reset master to sync with remote
```
git reset --hard origin/master
git pull origin master
```

