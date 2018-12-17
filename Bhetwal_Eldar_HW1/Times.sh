#!/bin/bash
#Pari Bhetwal
#Omer Eldar

#Terminate if Times.sh is not followed by a filename (the intended use) 
#fi closes the if statement 
#If greater than 1 argument or less than 1 argument, display usage
if [[ ($# -lt 1) || ($# -gt 1) ]]
then
	echo "Usage: $0 filename" 
	exit 1
fi

#$1 is the file name 
#This will allow us to sort by last name, then first name
sort -k3,3 -k2,2 $1 -o $1

#-a is an array flag, doing this allows us to store each part of the line an array 
#Then, we can use this array easily to get what we want from the line
#we can then create a variable called studentInfo 
#reading files is concluded with done < $1
while read -a athleteInfo;
do
	#First we add up all the times 
	sumOfTimes=`expr ${athleteInfo[3]} + ${athleteInfo[4]} + ${athleteInfo[5]}`
	#Then, we can divide sum by 3 to get the average for that line 
	averageTimes=`expr $sumOfTimes / 3`
	#Now, display in the format we want
	echo "${athleteInfo[0]} [$averageTimes] ${athleteInfo[2]}, ${athleteInfo[1]}"
done < $1