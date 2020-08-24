#!/bin/bash
# Code by Ruli Simanungkalit
#----------------- Variables -----------------#
flagPos="$(cat /path/to/.record)"
flagName="flag.txt"
userCommandHistory="/path/to/.history"
fileDestination="$(shuf -n 1 /path/to/dirList)"
#------------- End of Variables --------------#
#------------ Start of Functions -------------#
checkFileDestination() {
 while [[ "$flagPos" == "$fileDestination" ]]; do
  unset fileDestination
  fileDestination="$(shuf -n 1 /home/lab/clue/dirList)"
 done
 if [ ! -d $fileDestination ]; then
  mkdir -p $fileDestination
 fi
}
moveFlag() {
 mv $flagPos$flagName $fileDestination > /dev/null
 echo "$fileDestination" > /path/to/.record
 unset flagPos
 flagPos="$fileDestination"
}
#------------ End of Functions ------------#
#------------------ Main ------------------#
while read line; do
 if echo "$line" | grep -q "${flagPos%/*/*/}"; then
  checkFileDestination
  moveFlag
 fi
done < $userCommandHistory