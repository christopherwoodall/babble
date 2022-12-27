Description: Connections grouped by IP and Port
Type: Connections
Query: event.dataset:conn | groupby source.ip destination.ip network.protocol destination.port
---

Description: DCE_RPC grouped by operation
Type: DCE_RPC
Query: event.dataset:dce_rpc | groupby dce_rpc.operation
---

Description: DHCP leases
Type: DHCP
Query: event.dataset:dhcp | groupby host.hostname client.address
---

Description: DNS grouped by parent domain
Type: DNS
Query: event.dataset:dns | groupby dns.parent_domain.keyword destination.port
---

Description: Dynamic Protocol Detection errors
Type: DPD
Query: event.dataset:dpd | groupby error.reason
---

Description: Files grouped by mimetype
Type: Files
Query: event.dataset:file | groupby file.mime_type source.ip
---

Description: Files grouped by source
Type: Files
Query: event.dataset:file | groupby file.source source.ip
---

Description: FTP grouped by command and argument
Type: FTP
Query: event.dataset:ftp | groupby ftp.command ftp.argument
---

Description: FTP grouped by username and argument
Type: FTP
Query: event.dataset:ftp | groupby ftp.user ftp.argument
---

Description: HTTP grouped by destination port
Type: HTTP
Query: event.dataset:http | groupby destination.port
---

Description: HTTP grouped by status code and message
Type: HTTP
Query: event.dataset:http | groupby http.status_code http.status_message
---

Description: HTTP grouped by method and user agent
Type: HTTP
Query: event.dataset:http | groupby http.method http.useragent
---

Description: HTTP grouped by virtual host
Type: HTTP
Query: event.dataset:http | groupby http.virtual_host
---

Description: HTTP with exe downloads
Type: HTTP
Query: event.dataset:http AND (file.resp_mime_types:dosexec OR file.resp_mime_types:executable) | groupby http.virtual_host
---

Description: Intel framework hits grouped by indicator
Type: Intel
Query: event.dataset:intel | groupby intel.indicator.keyword
---

Description: IRC grouped by command
Type: IRC
Query: event.dataset:irc | groupby irc.command.type
---

Description: Kerberos grouped by service
Type: Kerberos
Query: event.dataset:kerberos | groupby kerberos.service
---

Description: MODBUS grouped by function
Type: MODBUS
Query: event.dataset:modbus | groupby modbus.function
---

Description: MYSQL grouped by command
Type: MYSQL
Query: event.dataset:mysql | groupby mysql.command
---

Description: Zeek notice logs grouped by note and message
Type: NOTICE
Query: event.dataset:notice | groupby notice.note notice.message
---

Description: NTLM grouped by computer name
Type: NTLM
Query: event.dataset:ntlm | groupby ntlm.server.dns.name
---

Description: Osquery Live Query results grouped by computer name
Type: Osquery Live Queries
Query: event.dataset:live_query | groupby host.hostname
---

Description: PE files list
Type: PE
Query: event.dataset:pe | groupby file.machine file.os file.subsystem
---

Description: RADIUS grouped by username
Type: RADIUS
Query: event.dataset:radius | groupby user.name.keyword
---

Description: RDP grouped by client name
Type: RDP
Query: event.dataset:rdp | groupby client.name
---

Description: RFB grouped by desktop name
Type: RFB
Query: event.dataset:rfb | groupby rfb.desktop.name.keyword
---

Description: Zeek signatures grouped by signature id
Type: Signatures
Query: event.dataset:signatures | groupby signature_id
---

Description: SIP grouped by user agent
Type: SIP
Query: event.dataset:sip | groupby client.user_agent
---

Description: SMB files grouped by action
Type: SMB_Files
Query: event.dataset:smb_files | groupby file.action
---

Description: SMB mapping grouped by path
Type: SMB_Mapping
Query: event.dataset:smb_mapping | groupby smb.path
---

Description: SMTP grouped by subject
Type: SMTP
Query: event.dataset:smtp | groupby smtp.subject
---

Description: SNMP grouped by version and string
Type: SNMP
Query: event.dataset:snmp | groupby snmp.community snmp.version
---

Description: List of software seen on the network
Type: Software
Query: event.dataset:software | groupby software.type software.name
---

Description: SSH grouped by version and client
Type: SSH
Query: event.dataset:ssh | groupby ssh.version ssh.client
---

Description: SSL grouped by version and server name
Type: SSL
Query: event.dataset:ssl | groupby ssl.version ssl.server_name
---

Description: SYSLOG grouped by severity and facility
Type: SYSLOG
Query: event.dataset:syslog | groupby syslog.severity_label syslog.facility_label
---

Description: Tunnels grouped by type and action
Type: Tunnel
Query: event.dataset:tunnel | groupby tunnel.type event.action
---

Description: Zeek weird log grouped by name
Type: Weird
Query: event.dataset:weird | groupby weird.name
---

Description: x.509 grouped by key length and name
Type: x509
Query: event.dataset:x509 | groupby x509.certificate.key.length x509.san_dns
---

Description: x.509 grouped by name and issuer
Type: x509
Query: event.dataset:x509 | groupby x509.san_dns x509.certificate.issuer
---

Description: x.509 grouped by name and subject
Type: x509
Query: event.dataset:x509 | groupby x509.san_dns x509.certificate.subject
---

Description: Firewall events grouped by action
Type: Firewall
Query: event.dataset:firewall | groupby rule.action
---

