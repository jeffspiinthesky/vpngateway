# vpngateway

## Introduction
This project is used to configure a Raspberry PI as a VPN gateway. These config files assume you're using eth0 as your main NIC and VPN connections appear as tun<something>.

## Installation
Set up your Raspberry PI as a routing node
```
sudo cp 99-ip-forward.conf /etc/sysctl.d/
```
Then install iptables and iptables-persistent
```
sudo apt install -y iptables iptables-persistent
```
Once complete, set up iptables rules for the VPN gateway
```
sudo ./set-iptables.sh
```
Save the iptables config so it will persist a reboot
```
sudo netfilter-persistent save
```
Install OpenVPN or your VPN provider of choice
```
sudo apt install -y openvpn
```
Copy your client configuration file to the OpenVPN client config directory
```
sudo cp openvpn.conf /etc/openvpn/client/
```
Enable and start the VPN software
```
sudo systemctl enable openvpn-client@openvpn
sudo systemctl start openvpn-client@openvpn
```

OPTIONAL: If your VPN requires credentials, create /etc/openvpn/client/creds.conf containing username and password as only two lines of the file. Then edit the /etc/openvpn/client/openvpn.conf file and add the following line:
```
auth-user-pass /etc/openvpn/client/creds.conf
```
Save the configuration file.

## Usage
Once set up, configure the default gateway for another device on your network to use the Raspberry PI as its default gateway. All traffic to/from that device will then be routed via the VPN.
