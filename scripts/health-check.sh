#!/bin/bash

echo "===== SERVER HEALTH REPORT ====="
echo "Date: $(date)"
echo "Hostname: $(hostname)"

echo
echo "===== SYSTEM UPTIME ====="
uptime

echo
echo "===== MEMORY USAGE ====="
free -h

echo
echo "===== DISK USAGE ====="
df -h /

echo
echo "===== NGINX STATUS ====="
if systemctl is-active --quiet nginx; then
    echo "Nginx is RUNNING"
else    echo "Nginx is NOT RUNNING"
fi

echo
echo "===== HTTP TEST ====="

http_code=$(curl -s --max-time 5 -o /dev/null -w "%{http_code}" http://localhost)
curl_result=$?

echo "HTTP Status: $http_code"

if [ "$curl_result" -ne 0 ]; then
    echo "ERROR: Could not connect to the web server"
    exit 1
elif [ "$http_code" -ne 200 ]; then
    echo "WARNING: Unexpected HTTP response"
    exit 1
else
    echo "SUCCESS: Web server is responding normally"
fi
