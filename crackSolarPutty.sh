#!/bin/bash

# Function to display help
function show_help {
  echo "Usage: ./crackSolarPutty.sh -f <solar.dat> -w <wordlist>"
  echo ""
  echo "Options:"
  echo "  -f    Specify the SolarPutty encrypted file (e.g., solar.dat)"
  echo "  -w    Specify the wordlist to use for brute forcing"
  echo "  -h    Show this help message and exit"
}

# Variables for file and wordlist
ENC_FILE=""
WORDLIST=""

# Parse command line arguments
while getopts ":f:w:h" opt; do
  case ${opt} in
    f )
      ENC_FILE=$OPTARG
      ;;
    w )
      WORDLIST=$OPTARG
      ;;
    h )
      show_help
      exit 0
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      show_help
      exit 1
      ;;
    : )
      echo "Option -$OPTARG requires an argument." 1>&2
      show_help
      exit 1
      ;;
  esac
done

# Check if file and wordlist are provided
if [ -z "$ENC_FILE" ] || [ -z "$WORDLIST" ]; then
  echo "Both -f (file) and -w (wordlist) options are required."
  show_help
  exit 1
fi

# Path to the SolarPuttyDecrypt executable
DECRYPT_TOOL="./SolarPuttyDecrypt.exe"

# Ensure the file and wordlist exist
if [ ! -f "$ENC_FILE" ]; then
  echo "Error: File $ENC_FILE not found!"
  exit 1
fi

if [ ! -f "$WORDLIST" ]; then
  echo "Error: Wordlist $WORDLIST not found!"
  exit 1
fi

# Loop through each password in the wordlist
while IFS= read -r password; do
  echo "Trying password: $password"

  # Run the decryption tool with the current password
  $DECRYPT_TOOL $ENC_FILE $password > output.json 2>&1

  # Check for the keyword "Sessions" in the output to confirm successful decryption
  if grep -q '"Sessions":' output.json; then
    echo "Password found: $password"
    echo "Decryption successful!"
    cat output.json
    break
  else
    echo "Invalid password: $password"
  fi
done < "$WORDLIST"

