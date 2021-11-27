#!/bin/sh

PNAME="$( basename $0 )"

command -v acpi_listen > /dev/null 2>&1 || { printf "%s\n" "error: acpi_listen is required"; exit 1; }

_cleanup() {
    pkill -P $$
}

trap _cleanup EXIT TERM INT QUIT HUP

_run() {
    pidof -x "$PNAME" -o $$ >/dev/null && { printf "%s %s\n" "$PNAME" "is already running"; exit 1; }

    # listen to acpi events to update status bar
    acpi_listen | while IFS= read -r line; do
        case "$line" in
            jack/headphone*) pkill -RTMIN+10 dwmblocks;;
            battery*) sleep 0.5; pkill -RTMIN+12 dwmblocks;;
        esac
    done &
    
    ${PWD}/dwmblocks & wait
    exit 0
}

case "$1" in
    run) _run;;
esac
