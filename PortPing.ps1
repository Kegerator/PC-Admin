<#
Standard Windows Ports
21 FTP
22 SSH
23 Telnet
25 SMTP
37 Time
53 DNS
67 DHCP
68 DHCP
69 TFTP
79 Finger
80 HTTP
88 Kerberos
115 SFTP
118 SQL
123 Network Time Protocol
135 Microsoft End Point Mapper 
137 NetBIOS
138 NetBIOS
139 NetBIOS
143 IMAP (Internt Message Access Protocol)
156 SQL
161 SNMP
162 SNMP
389 LDAP
401 UPS (Uninterruptible Power Supply)
433 NNTP (Network News Protocol)
443 HTTPS
445 Active Directory
445 Active Directory \ SMB
464 Keberos
465 SMTP
514 Remote Shell \ Syslog
530 RPC (Remote Procedure Call)
543 Kerberos Login
546 DHCPv6 Client
547 DCHPv6 Server
3020 SMB

3cx Ports
  Open these ports to allow 3CX to communicate with the VoIP Provider/SIP Trunk and WebRTC:
    Port 5060 (inbound, UDP) and 5060-5061 (inbound, TCP) for SIP communications.
    Port 9000-10999 (inbound, UDP) for RTP (Audio) communications, i.e. the actual call. Each call requires 2 RTP ports, one to control the call and one for the call data, so the number of ports you need to open is double the number of simultaneous calls.
  3cx Ports required for remote 3CX Apps & SBC
    Port 5090 (inbound, UDP and TCP) for the 3CX tunnel.
    Port 443 or 5001 (inbound, TCP) HTTPS for Presence and Provisioning, or the custom HTTPS port you specified.
    Port 443 (outbound, TCP) for Google Android Push.
    Port 443, 2197 and 5223 (outbound, TCP) for Apple iOS Push
  3cx Video Confernce
    Port 443 (inbound, TCP) must be allowed for participants to connect your 3CX System
    3CX System: Port 443 (outbound, TCP) must be allowed to connect to 3CX’s cloud infrastructure
    Users: Port 443 (outbound, TCP) and 48000-65535 (outbound, UDP) must be allowed to exchange audio and video with other participants
  Ports required for Other Services (SMTP & Activation)
    SMTP Service: Cloud Service for SMTP Messages
        smtp-proxy.3cx.net, 2528 (outbound, TCP)
    Activation Service: Activation of 3CX Products
        activate.3cx.com, 443 (outbound, TCP, uninspected traffic)
    RPS Service: Provisioning of Remote IP Phones
        rps.3cx.com, 443 (outbound, TCP)
    Update Server: For updates of 3CX System and firmware of IP Phones
        Downloads-global.3cx.com, 443 (outbound, TCP)

UniFi Network - Rquired Ports
  Local Ingress Ports (Incoming)
    Protocol 	Port Number 	Usage
    TCP/UDP     53              Used for DNS. This is required for Guest Portal redirection, downloading updates, and remote access.
    UDP         3478            Used for STUN.
    UDP         5514            Used for remote syslog capture.
    TCP         8080            Used for device and application communication.
    TCP         443             Used for application GUI/API as seen in a web browser. Applications running on a UniFi Console
    TCP         8443            Used for application GUI/API as seen in a web browser. Applications running on a  Windows/macOS/Linux machine
    TCP         8880            Used for HTTP portal redirection.
    TCP         8843            Used for HTTPS portal redirection.
    TCP         6789            Used for UniFi mobile speed test.
    TCP         27117           Used for local-bound database communication.
    UDP         5656-5699       Used by AP-EDU broadcasting.
    UDP         10001           Used for device discovery.
    UDP         1900            Used to "Make application discoverable on L2 network" in the UniFi Network settings.
    UDP         123             Used for NTP (date and time). Required for establishing secure communication with remote access servers.
  Ingress Ports Required for L3 Management Over the Internet (Incoming)
    Protocol   Port Number      Usage
    UDP        3478             Used for STUN.
    TCP        8080             Used for device and application communication.
    TCP        443              Used for application GUI/API as seen in a web browser. Applications running on an UniFi Console
    TCP        8443             Used for application GUI/API as seen in a web browser. Applications running on Windows/macOS/Linux machines
    TCP        6789             Used for UniFi mobile speed test.
    TCP        8880             Used for HTTP portal redirection. (only needed if using Guest hotspot)
    TCP        8843             Used for HTTPS portal redirection. (only needed if using Guest hotspot)
  Egress Ports Required for UniFi Remote Access (Exiting)
    Protocol   Port Number      Usage
    TCP/UPD    53               Used for DNS This is required for Guest Portal redirection, downloading updates, and remote access.
    UDP        3478             Used for STUN.
    TCP/UDP    443              Used for Remote Access service.
    TCP        8883             Used for Remote Access service.
    UDP        123              Used for NTP (date and time). Required for establishing secure communication with remote access servers.

Grace Digital
    Ports that need to be open for plus series radios
    For internet traffic: TCP ports 80 and 443 and UDP ports 53, 67 and 123.
    For UPnP UDP 5000 (but since he can play UpnP files that port seems to be open already)
    For Chromecast to work as well as our smartphone remote app to work: mDNS discovery needs to be turned on.  This is typically on by default on most routers.

Axcient
  AxCent requires access to these ports:Direct-to-Cloud (D2C) agent requirements
    The x360Recover Direct-to-Cloud (D2C) agent requires the following firewall ports to be open for outbound communications on the internet:
    TCP 80 (http)
    TCP 443 (https)
    TCP 9079 (Endpoint Manager)
    TCP 9082 (Cloudserver)
    TCP 9083 (Disaster Recovery Access Layer - DRAL )
    TCP 9090 (Backup Manager)
    TCP/UDP 10000 - 11024 (FTPS PASV - for FTP recovery from vault)
  Recovery Center requirements
    x360Recover Recovery Center requires the following ports to be open:
    TCP/443 (https) to the vault (or appliance) holding the data to be recovered
    TCP/443 (https) to api.axcient.net
    TCP/9083 (Disaster Recovery Access Layer [DRAL]) to the Axcient Scale-Out Cloud storage node 
  Common requirements for appliances and vaults 
    All x360Recover devices must be able to communicate with the following destinations and ports: 
	  Distributed Tunnel Service
      TCP/2222 - rb-prd-slcflow.slc.efscloud.net 
    x360Recover License Portal
      TCP/443 (https) - Used to access API endpoints
      URL: licensing.replibit.com
      IP: 198.73.17.63
    Cloud Key Management Services
      TCP/443 (https) – Used to access API endpoints 
      URL: appliances.efscloud.net
      IP(s): 143.204.29.2/143.204.29.74/143.204.29.16/143.204.29.87
      Note: IP addresses subject to change
    Telemetry Services
      The  x360Recover telemetry service utilizes a highly-dispersed cloud data provider with a large list of volatile IP addresses.  A list of the current IP addresses in use can be found here
    Update Manager
      TCP/80 (http) - Used for package downloads and version updates
      URL(s): pkgmgrrepo.replibit.net
      IP(s): highly volatile (Amazon AWS S3 service)
    Update Repository
      TCP/443 (https) – Used for software updates and custom package distribution
      URL: download.slc.efscloud.net
      IP: 198.73.17.62
    Ubuntu Package Mirror
      URL: rb-mirror.slc.efscloud.net
      IP: 198.73.17.51
  Outboud Traffic
    Management Portal
      TCP/22 (ssh) – Used to establish secure tunnel for remote management and Remote Assist
      TCP/443 (https) – Used for accessing API endpoints
    Vault
      TCP/443(https)
      TCP/9080(vt1)
      TCP/9081(vt2)
    Scale-Out Cloud
      TCP/9081(vt2)
          
#>


# Prompt the user for the IP address or site name
$target = Read-Host "Enter the IP address or site name to test"

# Prompt the user for the port number
$port = Read-Host "Enter the port number to check"

# Test the connection
try {
    test-netconnection $target -InformationLevel "Detailed"
} catch {
    Write-Host "Test Net Connection failed: $($_.Exception.Message)"
}

<#
# Ping 3 times
try {
    $pingResult = Test-Connection -ComputerName $target -Count 3 -ErrorAction Stop 
} catch {
    Write-Host "Ping failed: $($_.Exception.Message)"
}
Write-Host "---Pinging--- "
$pingResult | Select-Object ResponseTime
#>

# Test the TCP connection
try {
    $tcpClient = New-Object System.Net.Sockets.TcpClient
    $tcpClient.Connect($target, $port)

    if ($tcpClient.Connected) {
        Write-Host "TCP Connection to $target on port $port is successful."
    } else {
        Write-Host "TCP Connection to $target on port $port failed."
    }

    $tcpClient.Close()
} catch {
    Write-Host "TCP Error: $_.Exception.Message"
} finally {
    $udpClient.Close()
}