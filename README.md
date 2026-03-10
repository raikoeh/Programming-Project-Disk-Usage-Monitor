# Disk Usage Monitor
This project monitors disk usage and storage by checking the size of directories, reporting the percent usage that each directory takes up, and prints a summary of the total disk size, number of directories checked, and the number of warnings issued. 

## Contents
- README.md: Instructions for the project, examples of input/output
- scripts: My code for the project

## Usage:
The script requires at least two arguments, which are a threshold percent and at least one input directory to check. 
Example usage: ./disk_monitor.sh 80 /tmp /directory/data

## Input: 
The input will be the threshold of the user's choice and any directories to check.
Example: 80 /tmp /directory/data

## Output:
The output will be a report of a directory's size in human-readable format. If the directory exceeds the input threshold, a warning will be issued. 
/tmp 	    	 350M
/directory/data  20G    [Warning: exceeds 80% threshold]

## Dependencies
This script uses standard Unix commands, so there are no other external libraries or packages required.


## AI assistance
I used AI to assist with picking the correct options for commands, like the -sk option for du to get the size in kilobytes. I also used AI to help me define the "results" variable that holds the information from the analysis loop.
