#!/bin/sh


nmcli -g name,type connection show --active | awk -F: '$2 == "vpn" { print $1; exit }'