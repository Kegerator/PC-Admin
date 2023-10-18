# This will create a new inbound rule that allows TCP traffic on port 8080, and UDP on port 10001
# These ports are needed for device discovery and application cummunication.

New-NetFirewallRule -DisplayName "Allow Port 8080" -Direction Inbound -Protocol TCP -LocalPort 8080 -Action Allow
New-NetFirewallRule -DisplayName "Allow Port 10001" -Direction Inbound -Protocol UDP -LocalPort 10001 -Action Allow
# This is the minimum needed on the machine running the UniFi Network application.
# Other ports may be need on the machine running the UniFi Network application, or the firewall

<#
UniFi Network - Required Ports Reference
Updated on Jul 24, 2023

The following lists the UDP and TCP ports used by UniFi. This information mainly applies to users with a self-hosted UniFi Network Server, or users with third-party devices and firewalls. For this reason, we generally recommend a full UniFi deployment for seamless deployment and optimal native compatibility.
Local Ingress Ports (Incoming)
Protocol 	Port Number 	Usage
TCP/UDP 	53 		Used for DNS. This is required for Guest Portal redirection, downloading updates, and remote access.
UDP 		3478 		Used for STUN.
UDP 		5514 		Used for remote syslog capture.
TCP 		8080 		Used for device and application communication.
TCP 		443 		Used for application GUI/API as seen in a web browser. Applications running on a UniFi Console
TCP 		8443 		Used for application GUI/API as seen in a web browser. Applications running on a  Windows/macOS/Linux machine
TCP 		8880 		Used for HTTP portal redirection.
TCP 		8843 		Used for HTTPS portal redirection.
TCP 		6789 		Used for UniFi mobile speed test.
TCP 		27117 		Used for local-bound database communication.
UDP 		5656-5699 	Used by AP-EDU broadcasting.
UDP 		10001 		Used for device discovery.
UDP 		1900 		Used to "Make application discoverable on L2 network" in the UniFi Network settings.
UDP 		123 		Used for NTP (date and time). Required for establishing secure communication with remote access servers.

Ingress Ports Required for L3 Management Over the Internet (Incoming)

These ports need to be open at the gateway/firewall as well as on the machine running the UniFi Network application. This would be achieved by creating port forwards on the gateway/firewall where the application is running.
Protocol	Port Number	Usage
UDP 		3478 		Used for STUN.
TCP 		8080 		Used for device and application communication.
TCP 		443 		Used for application GUI/API as seen in a web browser. Applications running on an UniFi Console
TCP 		8443		Used for application GUI/API as seen in a web browser. Applications running on Windows/macOS/Linux machines
TCP 		6789 		Used for UniFi mobile speed test.
TCP 		8880 		Used for HTTP portal redirection. (only needed if using Guest hotspot)
TCP 		8843 		Used for HTTPS portal redirection. (only needed if using Guest hotspot) 

Egress Ports Required for UniFi Remote Access (Exiting)
In most cases, these ports will be open and unrestricted by default.
Protocol 	Port Number 	Usage
TCP/UPD 	53 		Used for DNS This is required for Guest Portal redirection, downloading updates, and remote access.
UDP 		3478 		Used for STUN.
TCP/UDP 	443 		Used for Remote Access service.
TCP 		8883 		Used for Remote Access service.
UDP	 	123 		Used for NTP (date and time). Required for establishing secure communication with remote access servers.
#>