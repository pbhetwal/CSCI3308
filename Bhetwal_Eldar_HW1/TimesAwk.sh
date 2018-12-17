#!/bin/bash
#Pari Bhetwal
#Omer Eldar

#Terminate if TimesAwk.sh is not followed by a filename (the intended use) 
#fi closes the if statement 
#If greater than 1 argument or less than 1 argument, display usage
if [[ ($# -lt 1) || ($# -gt 1) ]]
then
	echo "Usage: $0 filename" 
	exit 1
fi

#This will allow us to sort by last name, then first name
sort -k3,3 -k2,2 $1 -o $1
#$1 is the file name 
#We must cast to integer to get same result as Times.sh 
awk '{print $1 " ["int(($4+$5+$6)/3)"] " $3 ", " $2}' $1