#!/bin/bash
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
    tput cuu 1 && tput el
    awk '/VmRSS/ {print $0}' < /proc/"$pid"/status 
    sleep 2
  done
else
  echo "Error: Process with PID $pid not found."
  exit 1
fi
