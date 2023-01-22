#!/usr/bin/env bash

function show_help() {

    cat >&2 << EOF
USAGE $(basename "$0") --all/--target"
========================================================================================================================
--all    - key displays the IP adressed and symboplic names of all hosts in the current subnet

--target - key displays a list of open system TCP ports
========================================================================================================================
EOF

}

function list_hosts() {

    net=$(ifconfig enp0s3 2>/dev/null|awk '/inet / {print $2}' | sed -E s/[0-9]+/*/4 )
    sudo nmap -sn "$net" | awk "gsub(/Nmap scan report for /, \"\")"

}

function list_ports() {

    sudo nmap -sT -O 127.0.0.1 | awk "/tcp/ {print $1}"

}


[ "$#" -ne 1 ] && show_help && exit 0

if [[ $1 = "--all" ]]; then
    list_hosts
elif [[ $1 = "--target" ]]; then
    list_ports
fi