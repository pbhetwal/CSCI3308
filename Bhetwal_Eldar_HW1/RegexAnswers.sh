#!/bin/bash
#Pari Bhetwal
#Omer Eldar

#Terminate if RegexAnswers.sh is not followed by a filename (the intended use) 
#fi closes the if statement 
#If greater than 1 argument or less than 1 argument, display usage
if [[ ($# -lt 1) || ($# -gt 1) ]]
then
	echo "Usage: $0 filename" 
	exit 1
fi

#As the write up says, we must use egrep and pipe to wc -l 
#"$" means ends with 
echo "1. How many lines end with a number?"
egrep '[0-9]$' $1 | wc -l

#"^" means starts with 
echo "2. How many lines start with a vowel?"
egrep '^[aeiouAEIOU]' $1 | wc -l

#[Aa-Zz] means the whole alphabet 
#Then, use {9} to limit to nine words 
echo "3. How many 9 letter (alphabet only) lines?"
egrep '^[Aa-Zz]{9}$' $1 | wc -l 

#This question was from lab 2
#We weant any number (3 digits), any number(3 digits), any number(4 digits)
echo "4. How many phone numbers are in the dataset (format: ‘_ _ _-_ _ _-_ _ _ _’)?"
egrep '^[0-9]{3}-[0-9]{3}-[0-9]{4}' $1 | wc -l

#This question was from lab 2 but starting with only 303
#Similar to question 4. except 303 is static, not looking for range 
echo "5. How many city of Boulder phone numbers (starting with 303)?"
egrep '^303-[0-9]{3}-[0-9]{4}' $1 | wc -l

#Start with any number, .+ means anything afterwards, then has to end with vowel 
echo "6. How many lines begin with a number and end with a vowel?"
egrep '^[0-9].+[aeiouAEIOU]$' $1 | wc -l

#STarts with anything, ends with UC Denver address 
echo "7. How many email addresses are from UC Denver? (Eg: end with UCDenver.edu)?"
egrep '.+@UCDenver.edu$' $1 | wc -l

#^ matches position just before the first character of the string
#First, we find lines that start in the (n-z) range that are upper or lower case
#Begin with n-z range, followed by any alphabet character, number, or hyphen, then literal dot, then any alphabet, number or hyphen then @ and then any other characters 
echo "8. How many email addresses are in ‘first.last’ name format and involve someone whose first name starts with a letter in the second half of the alphabet (n-z)?"
egrep '^[n-zN-Z][a-zA-Z]*\.[a-zA-Z]*@.+$' $1 | wc -l