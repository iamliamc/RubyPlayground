#cd "/Users/liam/Downloads/test/"

files=(*.csv)

for ((i=0; i+1<${#files[@]}; i++)); do
 first="${files[$i]}"
 second="${files[$i+1]}"
 echo
 echo Comparing: $first and $second
 echo
 wdiff -n <(sort $first) <(sort $second) | colordiff | head
done
