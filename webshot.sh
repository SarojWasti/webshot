#!/bin/bash
printf "Finding Subdomains\n\n"

subfinder -dL $1 -silent -o subdomains.txt | httprobe > alivedomains.txt
rm -rf subdomains.txt
echo "Alive domains: "
printf "\n"

cat alivedomains.txt && printf "\n"

mkdir shots
while IFS= read line
do
  screenshot=$(echo "$line" | sed 's/https\?:\/\///' | sed 's~/[a-z]*~~g')
  cutycapt --url=$line --out="shots/$screenshot".png --min-height=800
  echo "Screenshot taken for url: $line"
done < alivedomains.txt
