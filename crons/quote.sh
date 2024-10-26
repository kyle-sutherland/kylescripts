#!/bin/bash

# Define an array of excluded authors
# I don't find any of these to be an inspiring presence in my terminal.
# So add a name to the array and if it matches with the author of a quote you get,
# the script will ask for a new one after 100ms debounce.
excluded_authors=(
  "Ayn Rand"
  "Charles Darwin"
  "John D. Rockefeller"
  "Winston Churchill"
  "John Lennon"
  "Henry Ford"
  "George Washington"
  "Albus Dumbledore"
  "Andrew Carnegie"
  "Thomas Edison"
  "Christopher Columbus"
  )

# Function to check if an author is in the exclusion list
is_excluded_author() {
    for excluded_author in "${excluded_authors[@]}"; do
        if [[ "$1" == "$excluded_author" ]]; then
            return 0 # true, author is excluded
        fi
    done
    return 1 # false, author is not excluded
}

# Main loop to get a quote
while true; do
    # Get the quote and author
    response=$(curl -s https://zenquotes.io/api/random)
    IFS='@' read -r quote author <<< "$(echo "$response" | jq -r '.[0] | "\(.q)@\(.a)"')"

    # Check if the author is excluded
    if is_excluded_author "$author"; then
        sleep 0.1 # wait 100 milliseconds
        continue # Request a new quote
    else
        break # Author is not excluded, exit loop
    fi
done

# Format the quote message
m="$quote"$'\n'"        -- ${author}"

# Export the quote to the file
echo "export DAILY_QUOTE=\"$m\"" > /home/kyle/.scripts/daily_quote.sh
