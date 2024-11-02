#!/bin/bash
# This script takes an PID as an argument and continuously prints the memory usage in KB.
### fzh completion for zsh (lets you fuzzy search process by name): ####
# _fzf_complete_vmrss() {
#   _fzf_complete --multi --reverse --prompt="vmrss> " -- "$@" < <(
#     ps axo user,pid,ppid,start,time,comm
#   )
# }
# _fzf_complete_vmrss_post() {
#   awk '{print $2}'
# }

# Check if PID is provided as an argument
if [ "$1" = "" ]; then
  echo "Usage: $0 <pid>"
  exit 1
fi

pid=$1

# Check if the provided PID is a valid number
if ! [[ "$pid" =~ ^[0-9]+$ ]]; then
  echo "Error: PID must be a valid number."
  exit 1
fi

if [ -f /proc/"$pid"/status ]; then
  name=$(awk '/Name/ {print $0}' /proc/"$pid"/status)
  echo "PID: $pid $name selected"
  
  # Continuous loop to print VmRSS with a 2-second delay
  while true; do
    awk '/VmRSS/ {print $0}' < /proc/"$pid"/status 
    sleep 2
  done
else
  echo "Error: Process with PID $pid not found."
  exit 1
fi
