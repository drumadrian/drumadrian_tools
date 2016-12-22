ssh_cleaner() {

    argument_1=$1
    argument_2=$2
    argument_3=$3
    argument_4=$4

    # this was added to overcome a problem with running the function in a new shell
    # The env variables changed when this function was run as a bash scrip
    # source $HOME/.bash_profile

    if [[ -z $argument_1 ]]; then
        echo
        echo "MISSING HOST/IP ADDRESS"
        echo
        return
    fi

    new_command=`echo ssh $argument_1 | sed 's/_/./g' | sed 's/-/./'g`


    echo "========================"
    echo "========================"
    echo "you gave: "$argument_1
    echo "you got: "$new_command
    echo "========================"
    echo "========================"


    #execute command
    $new_command
}


alias sshc='ssh_cleaner'


# TEST stream edit
# echo 52.91.169_78 | sed 's/_/./' | sed 's/-/./'




