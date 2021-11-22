#!/bin/sh

_print_module() { printf "^c%s^%s%s" "$1" "$2" "$3"; }

# Modules

_time() {
    f_color="#10d0ff"
    icon=""
    time="$( date '+%H:%M' )"

    _print_module "${f_color}" "${icon}" " ${time}"
}

_date() {
    f_color="#ff00ff"
    icon=""
    date="$( date '+%a %d %b' )"

    _print_module "${f_color}" "${icon}" " ${date}"
}

_memory() {
    f_color="#eeee00"
    icon=""
    memory="$( free -h | awk '/Mem:/ {print $3}' )"

    _print_module "${f_color}" "${icon}" " ${memory}"
}

_uptime() {
    f_color="#ff55bb"
    icon="" 

    # calculate time since boot
    upsec="$(( $( date '+%s' ) - $( date -d "$( who -b | sed 's/^.*system boot[ ]*//' )" "+%s" ) ))"
    updays="$(( $upsec / 86400 ))"
    uphours="$(( $upsec / 3600 % 24 ))"
    upmin="$(( $upsec / 60 % 60 ))"

    # display message depending on amount of time passed
    case "${updays}${uphours}" in
        00) message="${upmin}m";; # less than 1 hour
        0*) message="${uphours}h ${upmin}m";; # less than 1 day
        *) message="${updays}d ${uphours}h";; # more than 1 day
    esac

    _print_module "${f_color}" "${icon}" " ${message}"
}

case "$1" in
    time) _time;;
    date) _date;;
    memory) _memory;;
    uptime) _uptime;;
esac
