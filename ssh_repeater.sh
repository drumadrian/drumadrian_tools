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

    argument_list=`echo $argument_1 $argument_2 $argument_3 $argument_4`

    echo "========================"
    echo "==== ssh_repeater() ===="
    echo "========================"
    echo "you gave: "$argument_1
    echo "you should get: "ssh $argument_list
    echo "========================"
    echo "========================"

    attempt=1

    ## Original Flow
    if [ -n "$(type -t ssh_cleaner)" ] && [ "$(type -t ssh_cleaner)" = function ];
        then echo Adrian\'s ssh_cleaner is a Function and it exists......so we will use it;
        while true;
            do ssh_cleaner $argument_list;
            sleep 3;
            let attempt++
            echo
            echo 'Attempt: '$attempt;
            echo 'Retrying.....';
            echo
        done
    else
        echo Adrian\'s ssh_cleaner is NOT a Function or does not exist....skipping ssh_cleaner;
        while true;
            do ssh $argument_list;
            sleep 3;
            let attempt++
            echo
            echo 'Attempt: '$attempt;
            echo 'Retrying.....';
            echo
        done
    fi


    ## Alternate flow
    # while true;
    #     do
    #         if [ -n "$(type -t ssh_cleaner)" ] && [ "$(type -t ssh_cleaner)" = function ];
    #             then
    #             echo ssh_cleaner is a Function and it exists......so we will use it;
    #             ssh_cleaner $argument_list;
    #         else
    #             echo ssh_cleaner is NOT a Function or does not exist....skipping ss_cleaner;
    #             ssh $argument_list;
    #         fi
    #     sleep 3;
    #     echo 'Retrying.....';
    # done


}


alias sshr='ssh_repeater'





# while true; do ssh 54.237.247.194; sleep 3; echo "Retrying....."; done

# while true; do echo 'Hello Server'; sleep 3; echo "Retrying....."; done






















