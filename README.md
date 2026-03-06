# Disk Usage Monitor

This project monitors disk usage by checking how much storage is left on it, and warns when disk storage is getting too full. This addresses and solves problems that arise when disk storage is full, like system freeze-ups, crashes, server issues, and more. 

## Contents
- README.md: Instructions for the project, examples of input/output
- scripts: My code for the project

# Usage:
./disk_monitor.sh 80 tmp/ directory/data

# Example output:
/tmp 	    	 350M
/directory/data  20G    [Warning: exceeds 80% threshold]

# Dependencies
This script uses standard Unix commands, so there are no other external libraries or packages required.


# AI assistance
I used AI to assist with picking the correct options for commands, like the -sk option for du to get the size in kilobytes. I also used AI to help me define the "results" variable that holds the information from the analysis loop.