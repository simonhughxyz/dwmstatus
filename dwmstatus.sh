#!/bin/sh

command -v acpi_listen > /dev/null 2>&1 || { printf "%s\n" "error: acpi_listen is required"; exit 1; }

# listens to acpi events to update statusbar and run dwmblocks
_run() {
    acpi_listen | while IFS= read -r line; do
        case "$line" in
            jack/headphone*) pkill -RTMIN+10 dwmblocks;;
            battery*) sleep 0.5; pkill -RTMIN+12 dwmblocks;;
        esac
    done &
    ${PWD}/dwmblocks
}

case "$1" in
    run) _run;;
esac
