##################################################
#input needed:
#-source ~/Projects/codetoolbox/update_puppet.sh
#-update-puppet IP_ADDRESS [noop: y|n]
#-update-puppet-master IP_ADDRESS [noop: y|n]
##################################################
pupit_function() {

    workon_dir="puppet-cloud2-amazon-aws"
    release_task_path="/Users/pattyramert/Projects/puppet-cloud/mindtouch/amazon-aws/release_tasks"
    host_param=$1
    noop=$2

    if [[ -z $host_param ]]; then
        echo "MISSING HOST"
        return
    fi

    if [[ -z $noop ]]; then
        noop='y'
    else
        noop='n'
    fi

    echo "========================"
    echo "virtual directory: "$workon_dir
    echo "release task path: "$release_task_path
    echo "host param: "$host_param
    echo "noop: "$noop
    echo "========================"

	pwd_string=$(pwd)
    pupit_command='The argument is: '$host_param
    echo $pupit_command

    workon $workon_dir
    cd $release_task_path
    fab puppet_apply:noop=$noop,host=$1
    deactivate
    cd $pwd_string
}

pupit_master_function() {

    workon_dir="puppet-cloud2-amazon-aws"
    release_task_path="/Users/pattyramert/Projects/puppet-cloud/mindtouch/amazon-aws/release_tasks"
    host_param=$1
    noop=$2

    if [[ -z $host_param ]]; then
        echo "MISSING HOST"
        return
    fi

    if [[ -z $noop ]]; then
        noop='y'
    else
        noop='n'
    fi

    echo "========================"
    echo "virtual directory: "$workon_dir
    echo "release task path: "$release_task_path
    echo "host param: "$host_param
    echo "noop: "$noop
    echo "========================"

    pwd_string=$(pwd)
    pupit_command='The argument is: '$host_param
    echo $pupit_command

    workon $workon_dir
    cd $release_task_path
    fab pm_up
    fab puppet:noop='y',host=$1
    deactivate
    cd $pwd_string
}

alias update-puppet=pupit_function
alias update-puppet-master=pupit_master_function
