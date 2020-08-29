# Commands
This is my notes of some useful terminal commands & other shortcurs

# Terminal
`ctrl + R`    # search previous command <br>
`find [path] | grep [filename]`     # find filenames that contain [filename] in [path] <br>
`ps -ax`    # list all process <br>
`lsof -i :8888`     # find which process is using some port, such as 8888 <br>
`curl http://localhost:8888/v1/chain/get_info`      # get the webpage in terminal <br>
`cat `which bundle` `   # this will first evaluation "which bundle" as a path, and cat this file <br>
`du -ch`     # see size of some file <br>
`cd -`       # cd to previous dir <br>
`command1 | xargs command2`     # pass result from command1 to command 2 as argument <br>
`chmod +x my_script.sh`         # add execution permission <br>

### SSH
`ssh-add -K ~/.ssh/id_rsa`  # forward identity before ssh <br>
`ssh something -A`  # -A will forward identity <br>

### Alias and Env
##### print out env variables
`printenv` 

##### sudo with preserved user env variable
`sudo -E [command]`<br>
`sudo --preserve-env [command]`

`alias`     # show all alias <br>
`alias be='bundle exec'`    # make an alias <br>
`export BE='bundle exec'`    # make an environment variable. aliases are only a shell feature. Environment variables are inherited by all subprocesses <br>
`declare -F`    # show all shell defined functions with details <br>
`declare -f`    # show all shell defined functions (only function names) <br>
`type function_name`    # show source of this function (can also used for other things like alias) <br>



# Ruby & Rails
`rvm list` <br>
`rvm use *[--default] [ruby version number]` <br>
`gem info *[gem package name]` <br>
`gem env` <br>
`gem list` <br>
`bundle exec rspec spec`    # run all tests <br>
`bundle install --force`    # force reinstall all gems <br>
`bi rspec xxx.spec -e 'some test'`  # only run 'some test' in the test suites


# Useful Shortcut
#### Editor
`ctrl + shift + K`  # remove whole line <br>
`ctrl + cmd + G`    # selectAll <br>
`DEL (fn + BACK)`   # delete backwards <br>
`cmd + DEL`         # deleteLine up to cursor <br>
`ctrl + DEL`        # delete the word backwards <br>
`ctrl + BACK`       # delete the word <br>
`cmd + Shift + D`   # duplicate line <br>
`cmd + D`           # add next <br>
`cmd + R`           # search tokens <br>
`cmd + Shift + R`   # search tokens globally <br>
`cmd + L`           # select whole line <br>
`cmd + Shift + P`   # console <br>
`cmd + Shift + H`   # replace all (VSCode) <br>
`cmd + ⇦ / ⇨`      # go to left/right most position <br>
`cmd + ⇧ / ⇩`      # go to top/bottom position<br>
`option + shift + ⇦ / ⇨`   # select left/right word <br>
`cmd + shift + ⇦ / ⇨`      # select line from left/right up to current cursor <br>
`cmd + shift + ⇧ / ⇩`      # select line from top/bottom up to current cursor<br>
`cmd + shift + option + ⇦ / ⇨`      # shrink/expand selection <br>
`ctrl + cmd + ⇦ / ⇨`       # move tabs to left/right window (VSCode) <br>
`shift + option + F`        # reformat file <br>

#### Chrome
`cmd + ⇦ / ⇨`      # go back/front <br>

#### General
`cmd + W`           # close current tab <br>
`cmd + Shift + W`   # close all <br>
`cmd + ,`           # go to options <br>
`cmd + ~`           # switch window of the same app (doesn't work in full screen mode) <br>

#### MAC
`cmd + Option + D`  # toggle Mac dock <br>
`cmd + shift + G`   # (in finder) go to folder <br>
`ctrl + ⇦ / ⇨`     # switch window <br>
`ctrl + ⇧`         # show windows overview <br>
`cmd + ctrl + q`    # sleep <br>

#### Vim
`gw` auto format commit msg (after selected all the lines) <br>
`dd` to cut the line and `p` to paste <br>


# Git
##### rebase interactively top n commit, @ is shortcut for HEAD
`git rebase -i @~n`

##### reset the last changes to staged from commited state 
`git reset --soft HEAD~1`   

##### git diff between two branches (of specific file)
`git diff [branch_1]..branch_2 [-- filename]`   
`git diff origin/ruby_2_3..origin/ruby_2_2 -- lib/ostruct.rb`   # example

##### squash current commit to previous commit
`git commit --amend`    

##### add each chunk interactively
`git add . -p`          

##### cherry-pick/checkout some file from local branch/commit
`git cherry-pick/checkout branch/commit -- filename`<br>

##### cherry-pick a remote branch
`git fetch remote_url && git cherry-pick FETCH_HEAD` <br>

##### clean all untracked files
`git clean -f -d`

##### pretty print log
`git log --pretty=oneline --graph --decorate --all`

##### git log in time range
`git log --since='FEB 10 2016' --until='FEB 19 2016'`

##### list all git alias
`git config -l | grep alias | sed 's/^alias\.//g'`

##### seach git log with some keyword
`git log -S"key_word"`

##### git clean untracked files
`git clean -f -d`   # clean all
`git clean -f filename` # celan specific file

##### hard reset master to sync with remote
```
git reset --hard origin/master
git pull origin master
```

##### checkout last branch
`git checkout -`

