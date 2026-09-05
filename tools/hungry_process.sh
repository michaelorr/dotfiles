#!/usr/bin/env bash

# This will help identify hungry processes that are chewing CPU and power

top -l 2 -s 2 -n 20 -o power -stats pid,command,cpu,power

# -l take multiple samples and run a comparison between them
# -s seconds in between samples
# -n top N results
# -o order by power
# -stats show these columns
