#!/usr/bin/env bash

function show_help() {

    cat >&2 << EOF
USAGE $(basename "$0") --all/--target"
EOF

}

function list_hosts() {

    net=$(echo $(hostname -i) | sed -E s/[0-9]+/*/4 )
    nmap -sn "$net" | awk "gsub(/Nmap scan report for /, \"\")"

}

function list_ports() {

    ip=$(hostname -i)
    nmap -sT -O 10.1.8.145 | awk "/tcp/ {print $1}"

}


[ "$#" -ne 1 ] && show_help && exit 0

if [[ $1 = "--all" ]]; then
    list_hosts
elif [[ $1 = "--target" ]]; then
    list_ports
fi