# CrackSolarPutty
Easy to use tool for cracking Solar Putty dat files on linux.

# Usage
1. Clone the repository or download the release file and unzipt it.
2. chmod +x crackSolarPutty.sh
3. Set the path of your dat file (-f) and wordlist (-w):
4. ./crackSolarPutty.sh -f solar.dat -w /usr/share/wordlists/rockyou.txt
5. The script will stop after the password is succesfully found and the file will automatically be decrypted.

# Reference
This script was created by adding a modification to [VoidSec's SolarPuttyDecrypt tool](https://github.com/VoidSec/SolarPuttyDecrypt).
