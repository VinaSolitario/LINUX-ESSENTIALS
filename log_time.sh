#!/bin/bash

GITHUB_USER=$(echo $GITHUB_REPOSITORY | cut -d '/' -f1)

echo "Current Date and Time: $(TZ=Asia/Manila date '+%a %b %d, %Y %H:%M:%S') - Logged by: $GITHUB_USER" >> log.txt
