#!/bin/bash
response=$(curl -s https://zenquotes.io/api/random)
IFS='@' read -r quote author <<< "$(echo "$response" | jq -r '.[0] | "\(.q)@\(.a)"')"
m="$quote"$'\n'"        -- ${author}"

cowfiles=( $(cowsay -l | tail -n +2 ) )
random_index=$((RANDOM % ${#cowfiles[@]}))
cowsay -f "${cowfiles[$random_index]}" "$m" | lolcat 
