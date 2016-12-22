ssh_cleaner() {

    argument_1=$1
    argument_2=$2
    argument_3=$3
    argument_4=$4

    # this was added to overcome a problem with running the function in a new shell
    # The env variables changed when this function was run as a bash scrip
    # source $HOME/.bash_profile

    if [[ -z $argument_1 ]]; then
        echo "MISSING HOST/IP ADDRESS"
        echo
        return
    fi

    new_command='echo "ssh $1" | sed 's/_/./' | sed 's/-/./''


    echo "========================"
    echo "you gave: "$argument_1
    echo "you got: "$new_command
    echo
    echo "complete release task path: "$complete_release_task_path
    echo "host param: "$host_param
    echo "noop: "$noop
    echo "========================"



}

ssh_repeater() {

    argument_1=$1
    argument_2=$2
    argument_3=$3
    argument_4=$4

    # this was added to overcome a problem with running the function in a new shell
    # The env variables changed when this function was run as a bash scrip
    # source $HOME/.bash_profile

    if [[ -z $argument_1 ]]; then
        echo "MISSING HOST/IP ADDRESS"
        echo
        return
    fi

    echo


    echo "========================"
    echo "you gave: "$argument_1
    echo "you got: "$release_task_path
    echo "complete release task path: "$complete_release_task_path
    echo "host param: "$host_param
    echo "noop: "$noop
    echo "========================"



}



alias sshc='ssh_cleaner'
alias sshr='ssh_repeater'








sss='echo "ssh $1" | sed 's/_/./' | sed 's/-/./''




echo "ssh $uipadd" | sed 's/_/./' | sed 's/-/./'




