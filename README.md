
Kippo-log.sh is a script to view daily Kippo activity.
It will print some statistics like:

    Total log in attempts
    Total unique passwords tried
    The number of log in attempts since the last execution of the script and how many of them were successful, as well as the number of actual sessions (not just random “drive bys” by bots).
    Most used passwords/usernames

It's also able to print a list of the downloaded files in the last couple days.  


Usage: ./kippo-log.sh [OPTIONS]
	-f NUMBER: show files that were downloaded in the last NUMBER days
	-p NUMBER: show the NUMBER most tried passwords
	-u NUMBER: show the NUMBER most tried usernames

exaxmple: ./kippo-log.sh -p 5 -u 5 

Total login attempts: 27237
Total unique passwords tried: 12175
New login attempts: 0
Successful attempts: 0
With activity: 0
Without activity: 0

-----------TOP 5 USERNAMES----------------- 

root		17198
test		240
oracle		229
nagios		205
admin		186

-----------TOP 5 PASSWORDS----------------- 

123456		474
changeme	272
password	265
123		152
test		145

