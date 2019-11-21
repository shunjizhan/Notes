# Commands
This is my notes of some useful terminal commands & other shortcurs

## Terminal
`printenv`
`ctrl + R`    # search previous command
`find [path] | grep [filename]`     # find filenames that contain [filename] in [path]
`ps -ax`    # list all process
`lsof -i :8888`     # find which process is using some port, such as 8888
`curl http://localhost:8888/v1/chain/get_info`      # get the webpage in terminal


## Ruby & Rails
`rvm list`
`rvm use *[--default] [ruby version number]`
`gem info *[gem package name]`
`gem env`


## Shortcut
`ctrl + shift + K`  # remove whole line
`ctrl + cmd + G`    # selectAll
`ctrl + Shift + K`  # deleteWholeLine
`cmd + DEL`         # deleteLine up to cursor
`cmd + Shift + D`   # duplicate line
`cmd + D`           # add next
`cmd + W`           # close current tab
`cmd + Shift + W`   # close all
`cmd + ,`           # go to options
`cmd + Shift + P`   # console
`cmd + R`           # search tokens
`cmd + Shift + R`   # search tokens globally
`cmd + Shift + r`   # chrome force refresh


## Git
`git rebase -i @~n`     # rebase interactively top n commit, @ is shortcut for HEAD
`git reset --soft HEAD~1`   # reset the last changes to staged from commited state