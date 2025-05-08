GITHUB_USER=$(echo $GITHUB_REPOSITORY |  cut -d '/' -f1

echo "Current Date and Time: $(TZ=Asia/Manila date '+%a %b %d, %Y %H:%M:%S') - Logged by: $GITHUB_USER" >> log.txt

COUNT=$(grep -c '^Current' log.txt) 

tail -n +1 log.txt | grep -v "Total logs recorded" > temp_log.txt
echo "Total logs recorded: $COUNT" >> temp_log.txt
mc temp_log.txt log.txt 