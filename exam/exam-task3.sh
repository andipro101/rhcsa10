if grep -rl "baseurl" /etc/yum.repos.d/ &>/dev/null
then
        echo -e "\033[32m[OK]\033[0m\t\t repository baseurl is configured on server1"
        SCORE=$(( SCORE + 5 ))
else
        echo -e "\033[31m[FAIL]\033[0m\t\t no repository baseurl found in /etc/yum.repos.d/ on server1"
fi
TOTAL=$(( TOTAL + 5 ))

if ssh root@server2 "grep -rl 'baseurl' /etc/yum.repos.d/" &>/dev/null
then
        echo -e "\033[32m[OK]\033[0m\t\t repository baseurl is configured on server2"
        SCORE=$(( SCORE + 5 ))
else
        echo -e "\033[31m[FAIL]\033[0m\t\t no repository baseurl found in /etc/yum.repos.d/ on server2"
fi
TOTAL=$(( TOTAL + 5 ))

if dnf repolist 2>/dev/null | grep -iE "BaseOS" &>/dev/null && dnf repolist 2>/dev/null | grep -iE "AppStream" &>/dev/null
then
        echo -e "\033[32m[OK]\033[0m\t\t BaseOS and AppStream repos are enabled on server1"
        SCORE=$(( SCORE + 5 ))
else
        echo -e "\033[31m[FAIL]\033[0m\t\t BaseOS and/or AppStream repo is not enabled on server1"
fi
TOTAL=$(( TOTAL + 5 ))

if ssh root@server2 "dnf repolist 2>/dev/null | grep -iE 'BaseOS'" &>/dev/null && ssh root@server2 "dnf repolist 2>/dev/null | grep -iE 'AppStream'" &>/dev/null
then
        echo -e "\033[32m[OK]\033[0m\t\t BaseOS and AppStream repos are enabled on server2"
        SCORE=$(( SCORE + 5 ))
else
        echo -e "\033[31m[FAIL]\033[0m\t\t BaseOS and/or AppStream repo is not enabled on server2"
fi
TOTAL=$(( TOTAL + 5 ))

if dnf install -y nmap &>/dev/null && dnf remove -y nmap &>/dev/null
then
        echo -e "\033[32m[OK]\033[0m\t\t software can be installed and removed on server1"
        SCORE=$(( SCORE + 5 ))
else
        echo -e "\033[31m[FAIL]\033[0m\t\t software installation failed on server1 - check repo URL and connectivity"
fi
TOTAL=$(( TOTAL + 5 ))

if ssh root@server2 "dnf install -y nmap &>/dev/null && dnf remove -y nmap" &>/dev/null
then
        echo -e "\033[32m[OK]\033[0m\t\t software can be installed and removed on server2"
        SCORE=$(( SCORE + 5 ))
else
        echo -e "\033[31m[FAIL]\033[0m\t\t software installation failed on server2 - check repo URL and connectivity"
fi
TOTAL=$(( TOTAL + 5 ))
