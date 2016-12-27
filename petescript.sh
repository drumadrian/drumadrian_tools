function ws {
    if [[ -z $1 || -z $2 ]]; then echo "Usage: ws sleep_time command"; return 1; fi;
    sleep=$1
    shift
    command=$*ls
    while true; do $command ; sleep $sleep; done
}
