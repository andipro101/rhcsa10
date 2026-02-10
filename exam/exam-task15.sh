ssh server2 "find /etc -type f -readable -print0 | xargs -0 -r grep -iH 'administrator'" > /root/lab15.check
if ssh server2 "cat /root/administratorfiles.txt" | diff -u <(sort /root/lab15.check) <(sort -) &>/dev/null
then
        echo -e "\033[32m[OK]\033[0m\t\t you correctly identified all files in /etc that contain the text administrator on server2"
        SCORE=$(( SCORE + 10 ))
else
        echo -e "\033[31m[FAIL]\033[0m\t\t you did not correctly identify all files in /etc that contain the text administrator on server2"
fi
TOTAL=$(( TOTAL + 10 ))
