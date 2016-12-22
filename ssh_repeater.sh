ssh_repeater() {


    #########################################
    # Usage:                                #
    #           sshr 54.165.181.103         #
    #    or                                 #
    #           sshr 54-165_181.103         #
    #                                       #
    #########################################

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


    echo "========================"
    echo "========================"
    echo "you gave: "$argument_1
    echo "you got: "$new_command
    echo "========================"
    echo "========================"


    if [ -n "$(type -t ssh_cleaner)" ] && [ "$(type -t ssh_cleaner)" = function ];
        then echo ssh_cleaner is a Function and it exists......so we will use it;
        while true;
            do ssh_cleaner $argument_1;
            sleep 3;
            echo 'Retrying.....';
        done
    else
        echo ssh_cleaner is NOT a Function or does not exist....skipping ss_cleaner;
        while true;
            do ssh $argument_1;
            sleep 3;
            echo 'Retrying.....';
        done

    fi

}


alias sshr='ssh_repeater'





# while true; do ssh 54.237.247.194; sleep 3; echo "Retrying....."; done

# while true; do echo 'Hello Server'; sleep 3; echo "Retrying....."; done


















    #     while true;
    #         do ssh_cleaner argument_1;


    #         sleep 3;
    #         echo 'Retrying.....';
    #     done












    # if [ -n "$(type -t ssh_cleaner)" ] && [ "$(type -t ssh_cleaner)" = function ];
    #     then echo ssh_cleaner is a Function and it exists......so we will use it;
    #     ssh_cleaner argument_1;
    # else
    #     echo ssh_cleaner is NOT a Function or does not exist....skipping ss_cleaner;
    # fi






















        while true;
            do






            sleep 3;
            echo 'Retrying.....';
        done













