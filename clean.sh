clean(){

    old_string=$1

    echo  'Input IP address='$1

    new_string=`echo $old_string | sed 's/_/./g' | sed 's/-/./'g`

    echo
    echo 'NEW Input IP address=    ' $new_string
    echo
    # return $new_string

}
