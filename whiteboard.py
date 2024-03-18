# You need to write a function, that returns the first non-repeated character in the given string.

# If all the characters are unique, return the first character of the string.
# If there is no unique character, return None.

# You can assume, that the input string has always non-zero length.

# Examples
# "test"   returns "e"
# "teeter" returns "r"
# "trend"  returns "t" (all the characters are unique)
# "aabbcc" returns None (all the characters are repeated)


# input - a string of letters / output - a single letter, the first letter that after looking thru entire string, is unique
# loop through string
# if char count = 1, return char (would this return the very first one?)

            
def solution(string):
    for char in string: # this is a linear 
        if string.count(char) == 1: #this is a linear count - this would be O(n**2) Not ideal! 
            return char
    return None