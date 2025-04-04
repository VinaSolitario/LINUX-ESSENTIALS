#!/bin/bash

echo -n "Please enter your exam score:"
read grade

if ! [[ "$grade" =~ ^[0-9]+$ ]] || [ "$grade" -lt 0 ] || [ "$grade" -gt 100 ]; then
echo "Invalid input."
exit 1
fi 

if [ "$grade" -ge 90 ]; then
echo "Grade A"
elif [ "$grade" -ge 80 ]; then
echo "Grade B"
elif [ "$grade" -ge 70 ]; then
echo "Grade C"
elif [ "$grade" -ge 60 ]; then
echo "Grade D"
else 
echo "Grade F" 
fi