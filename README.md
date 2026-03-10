# Disk Usage Monitor
This project monitors disk usage and storage by checking the size of directories, reporting the percent usage that each directory takes up, and prints a summary of the total disk size, number of directories checked, and the number of warnings issued. 

## Contents
- README.md: Instructions for the project, examples of input/output
- disk_monitor.sh: script for my project
- test.sh: example usage for disk_monitor.sh
- sample_directory(1-3), empty_directory: sample directories for running disk_monitor.sh

## Usage:
The script requires at least two arguments, which are a threshold percent and at least one input directory to check. 
Example usage: ./disk_monitor.sh 80 /tmp /directory/data

## Input: 
The input will be the threshold of the user's choice and any directories to check.
Usage: ./disk_monitor.sh 80 /tmp /directory/data
Input: 80 /tmp /directory/data

## Output:
The output will be a report of a directory's size in human-readable format. If the directory exceeds the input threshold, a warning will be issued. 
/tmp             350M
/directory/data  20G    [Warning: exceeds 80% threshold]

## Dependencies
This script uses standard Unix commands, so there are no other external libraries or packages required.

## AI assistance
Below are a list of instances where I used AI assistance
- disk_monitor.sh: picking the -sk option for the disk size in KB, help with defining the "results" variable, help with printf for output formatting
- test.sh: help with making sample directories
