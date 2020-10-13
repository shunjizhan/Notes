# Commands
This is my notes of some useful terminal commands & other shortcurs

## Terminal
`ctrl + R`    # search previous command 
`find [path] | grep [filename]`     # find filenames that contain [filename] in [path] 
`ps -ax`    # list all process 
`lsof -i :8888`     # find which process is using some port, such as 8888 
`curl http://localhost:8888/v1/chain/get_info`      # get the webpage in terminal 
`cat `which bundle` `   # this will first evaluation "which bundle" as a path, and cat this file 
`du -ch`     # see size of some file 
`cd -`       # cd to previous dir 
`command1 | xargs command2`     # pass result from command1 to command 2 as argument 
`chmod +x my_script.sh`         # add execution permission 

## SSH
`ssh-add -K ~/.ssh/id_rsa`  # forward identity before ssh 
`ssh something -A`  # -A will forward identity 

## Alias and Env
### print out env variables
`printenv` 

### sudo with preserved user env variable
`sudo -E [command]`
`sudo --preserve-env [command]`

`alias`     # show all alias 
`alias be='bundle exec'`    # make an alias 
`export BE='bundle exec'`    # make an environment variable. aliases are only a shell feature. Environment variables are inherited by all subprocesses 
`declare -F`    # show all shell defined functions with details 
`declare -f`    # show all shell defined functions (only function names) 
`type function_name`    # show source of this function (can also used for other things like alias) 



## Ruby and Rails
`rvm list` 
`rvm use *[--default] [ruby version number]` 
`gem info *[gem package name]` 
`gem env` 
`gem list` 
`bundle exec rspec spec`    # run all tests 
`bundle install --force`    # force reinstall all gems 
`bi rspec xxx.spec -e 'some test'`  # only run 'some test' in the test suites


## Useful Shortcut
### Editor
`ctrl + shift + K`  # remove whole line 
`ctrl + cmd + G`    # selectAll 
`DEL (fn + BACK)`   # delete backwards 
`cmd + DEL`         # deleteLine up to cursor 
`ctrl + DEL`        # delete the word backwards 
`ctrl + BACK`       # delete the word 
`cmd + Shift + D`   # duplicate line 
`cmd + D`           # add next 
`cmd + R`           # search tokens 
`cmd + Shift + R`   # search tokens globally 
`cmd + L`           # select whole line 
`cmd + Shift + P`   # console 
`cmd + Shift + H`   # replace all (VSCode) 
`cmd + ⇦ / ⇨`      # go to left/right most position 
`cmd + ⇧ / ⇩`      # go to top/bottom position
`option + shift + ⇦ / ⇨`   # select left/right word 
`cmd + shift + ⇦ / ⇨`      # select line from left/right up to current cursor 
`cmd + shift + ⇧ / ⇩`      # select line from top/bottom up to current cursor
`cmd + shift + option + ⇦ / ⇨`      # shrink/expand selection 
`ctrl + cmd + ⇦ / ⇨`       # move tabs to left/right window (VSCode) 
`shift + option + F`        # reformat file (VSCode) 
`cmd + 9`                   # jump to last tab

### Chrome
`cmd + ⇦ / ⇨`      # go back/front 

### General
`cmd + W`           # close current tab 
`cmd + Shift + W`   # close all 
`cmd + ,`           # go to options 
`cmd + ~`           # switch window of the same app (doesn't work in full screen mode) 

### MAC
`cmd + Option + D`  # toggle Mac dock 
`cmd + shift + G`   # (in finder) go to folder 
`ctrl + ⇦ / ⇨`     # switch window 
`ctrl + ⇧`         # show windows overview 
`cmd + ctrl + q`    # sleep 

### Vim
`gw` auto format commit msg (after selected all the lines) 
`dd` to cut the line and `p` to paste 


## Git
### get line history of line XXX of a file YYY
`git log -LXXX,+1:'path_to_YYY'`
`git log -L169,+1:'package.json'`   # example

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
`git cherry-pick/checkout branch/commit -- filename`

### cherry-pick a remote branch
`git fetch remote_url && git cherry-pick FETCH_HEAD` 

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

### git clean untracked files
`git clean -f -d`   # clean all
`git clean -f filename` # celan specific file

### hard reset master to sync with remote
```
git reset --hard origin/master
git pull origin master
```

### checkout last branch
`git checkout -`

