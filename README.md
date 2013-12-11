codeiq-cyberdefence-reversing-challenge
=======================================

Files for a reversing challenge from codeiq



README
======

This is a CodeIQ challenge.  You have to reverse engineer the crackme1 binary and figure out what password to pass it.  It ends up being a six digit number that it performs computations on.  The computations are things like, "the first digit and 3rd digit need to be equal" and "the 1st digit needs to be 2 less than the 2nd digit".  

I reversed engineered the binary, figured out all of the checks it was making, and then wrote a logic program in Haskell to take all the conditions and figure out what group of numbers satisfies all the conditions.




SCRATCHPAD
==========




6   8   6   7   3   1

---------------------
1   2   3   4   5   6
---------------------
_   9   9   9   _   9

_   8   8   8   _   8

7   7   7   7   _   7

6   6   6   6   _   6

5   5   5   5   _   5

4   4   4   4   4   4

3   3   _   _   3   3

2   2   _   _   2   2

1   _   _   _   1   1

0   _   _   _   0   0

- 1st and 3rd need to be equal
	so [1st, 3nd] is [9, 9] or
					 [8, 8] or
					 [7, 7] or
					 [6, 6] or
					 [5, 5] or
					 [4, 4] or
					 [3, 3] or
					 [2, 2] or
					 [1, 1] or
					 [0, 0] or
- 1st and 2nd, 1st needs to be 2 less than 2nd
	so [1st, 2nd] is [7, 9] or
					 [6, 8] or
					 [5, 7] or
					 [4, 6] or
					 [3, 5] or
					 [2, 4] or
					 [1, 3] or
					 [0, 2] or
- 3rd and 4th added together need to be 13
	so [3rd, 4th] is [9, 4] or
					 [8, 5] or
					 [7, 6] or
					 [6, 7] or
					 [5, 8] or
					 [4, 9] or
- floor(3rd / 5th) needs to be 2
	so [3rd, 5th] is [9, 4] or 
					 [8, 4] or
					 [8, 3] or
					 [7, 3] or
					 [6, 3] or
					 [5, 2] or
					 [4, 2] or
					 [2, 1] or
- (4th - 6th needs to be equal to 3rd)
	so [3rd, 4th, 6th] is [4, 9, 5] or 
						  [5, 9, 4] or
						  [6, 9, 3] or
						  [7, 9, 2] or
						  [8, 9, 1] or
						  [9, 9, 0] or
						  ...
