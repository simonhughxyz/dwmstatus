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

case "$1" in
    time) _time;;
    date) _date;;
    memory) _memory;;
esac
