#!/bin/sh

_print_module() { printf "^c%s^%s%s" "$1" "$2" "$3"; }

# Modules

_battery() {
    # Don't run if acpi not available
    command -v acpi > /dev/null 2>&1 || return
    f_color="#60ff60" # color when battery is above 50%
    f_color_med_power="#f0f000" # color when battery is bellow 50%
    f_color_low_power="#f0f000" # color when battery is bellow 50%
    f_color_no_power_draw="#bb00ff" # color when battery is not being discharged

    bat_space=""

    # for each battery
    acpi -b | while read line; do
        # get current charging state
        state="$(echo "$line" | awk '{print $3}')"
        state="${state%*,}"
        # get charge level
        charge="$(echo "$line" | awk -F',' '{print $2}')"
        charge="${charge%*%}"

        # set correct color based on charge level
        battery_color=$f_color
        if [ "$charge" -gt "75" ]; then
            icon=""
        elif [ "$charge" -gt "50" ]; then
            icon=""
        elif [ "$charge" -gt "20" ]; then
            icon=""
            battery_color=$f_color_med_power
        elif [ "$charge" -lt "5" ]; then
            icon=""
            battery_color=$f_color_low_power
        else
            icon=""
            battery_color=$f_color_low_power
        fi

        # override color if battery is not discharging
        if [ $state != "Discharging" ]; then
            battery_color=$f_color_no_power_draw
        fi

        _print_module "${battery_color}" "${bat_space}${icon}" "${charge}%"
        bat_space=" "
    done
}

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

_volume() {
    f_color="#10e070"
    mute_color="#dd1111"

    [ $1 ] && vol="$1" || vol="$( volume )"

	if [ "$vol" = "mute" ]; then
        f_color=$mute_color
        vol=""
        icon=""
    elif [ "$vol" -gt "100" ]; then
		icon=" "
        vol="${vol}%"
	elif [ "$vol" -lt "50" ]; then
		icon=" "
        vol="${vol}%"
	else
		icon=" "
        vol="${vol}%"
	fi

    _print_module "${f_color}" "${icon}" "${vol}${percentage}"
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

_keystate() {
    f_color="#ff1111"

    lockline=$(xset -q | grep "Num Lock")

    caplock=$(echo "$lockline" | awk '{print $4}')
    numlock=$(echo "$lockline" | awk '{print $8}')
    scrolllock=$(echo "$lockline" | awk '{print $12}')

    message=""

    [ "$caplock" = "on" ] && message="CAPS"
    [ "$numlock" = "on" ] && message="NUM"
    [ "$scrolllock" = "on" ] && message="SCROLL"

    [ -z "$message" ] || _print_module "${f_color}" "" "^c${f_color}^[${message}]"
}

case "$1" in
    battery) _battery | tr '\n' ' ';;
    time) _time;;
    date) _date;;
    volume) _volume;;
    memory) _memory;;
    uptime) _uptime;;
    keystate) _keystate;;
esac
