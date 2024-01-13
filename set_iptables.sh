#!/bin/bash

iptables -A FORWARD -i tun+ -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o tun+ -j ACCEPT
iptables -t nat -I POSTROUTING -o eth0 -s 10.8.0.0/24 -j MASQUERADE
iptables -A POSTROUTING -t nat -j MASQUERADE
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
