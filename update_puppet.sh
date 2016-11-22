##################################################
#input needed:
#-source ~/Projects/codetoolbox/update_puppet.sh
#-update-puppet IP_ADDRESS [noop: y|n]
#-update-puppet-master IP_ADDRESS [noop: y|n]
##################################################
pupit_function() {

    workon_environment_name="amazon-aws"
    my_code_dir=$HOME"/code/"
    release_task_path="puppet-cloud/mindtouch/amazon-aws/release_tasks"
    complete_release_task_path=$my_code_dir$release_task_path
    host_param=$1
    noop=$2

    # this was added to overcome a problem with running the function in a new shell
    # The env variables changed when this function was run as a bash scrip
    source $HOME/.bash_profile

    if [[ -z $host_param ]]; then
        echo "MISSING HOST"
        return
    fi

    if [[ -z $noop ]]; then
        noop='n'
    # else
    #     noop='n'
    fi

    echo "========================"
    echo "virtual environment name: "$workon_environment_name
    echo "release task path: "$release_task_path
    echo "complete release task path: "$complete_release_task_path
    echo "host param: "$host_param
    echo "noop: "$noop
    echo "========================"

	pwd_string=$(pwd)
    workon $workon_environment_name
    cd "complete_release_task_path"
    fab puppet_apply:noop=$noop,host=$1
    deactivate
    cd "$pwd_string"
}

pupit_master_function() {

    workon_environment_name="amazon-aws"
    my_code_dir=$HOME"/code/"
    release_task_path="puppet-cloud/mindtouch/amazon-aws/release_tasks"
    complete_release_task_path=$my_code_dir$release_task_path
    host_param=$1
    noop=$2

    # this was added to overcome a problem with running the function in a new shell
    # The env variables changed when this function was run as a bash scrip
    source $HOME/.bash_profile

    if [[ -z $host_param ]]; then
        echo "MISSING HOST"
        return
    fi

    if [[ -z $noop ]]; then
        noop='n'
    # else
    #     noop='n'
    fi

    echo "========================"
    echo "virtual environment name: "$workon_environment_name
    echo "release task path: "$release_task_path
    echo "complete release task path: "$complete_release_task_path
    echo "host param: "$host_param
    echo "noop: "$noop
    echo "========================"

    pwd_string=$(pwd)
    workon $workon_environment_name
    cd "$complete_release_task_path"
    fab pm_up
    fab puppet:noop=$noop,host=$1
    deactivate
    cd "$pwd_string"
}

alias update-puppet='pupit_function'
alias update-puppet-master='pupit_master_function'
