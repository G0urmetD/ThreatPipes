![alt text](https://github.com/G0urmetD/ThreatPipes/blob/master/pipes.png?raw=true)
# ThreatPipes
ThreatPipes is a reconnaissance tool that automatically queries 100’s of data sources to gather intelligence on IP addresses, domain names, e-mail addresses, names and more.
You simply specify the target you want to investigate, pick which modules to enable and then ThreatPipes will collect data to build up an understanding of all the entities and how they relate to each other.
DNS, Whois, Web pages, passive DNS, spam blacklists, file meta data, threat intelligence lists as well as services like SHODAN, HaveIBeenPwned? and more are used to find out more about a target and known affiliates.
The data returned from a ThreatPipes scan will reveal a lot of information about your target, providing insight into possible data leaks, vulnerabilities or other sensitive information that can be leveraged during a penetration test, red team exercise or for threat intelligence.

# requierements
Ubuntu 16 (or greater) |
Kali 2018 (or greater) |
Debian 9 (or greater) |
MacOS 10.14 (or greater)

2x six-core |
2+ GHz CPU |
8GB RAM |
20GB Free disk space

# installation
>sudo apt update

>sudo apt install python3-venv

>tar xzvf threatpipes.tar.gz

>cd threatpipes

>./threatpipes.sh prodinstall


# start the service
>systemctl stop threatpipes

>systemctl start threatpipes

>systemctl restart threatpipes

>systemctl status threatpipes

