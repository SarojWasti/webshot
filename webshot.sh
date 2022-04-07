#!/bin/bash
subfinder -dL $1 -o subdomains.txt | httprobe > alivedomains.txt
rm -rf subdomains.txt
mkdir shots
while IFS= read line
do
  screenshot=$(echo "$line" | sed 's/https\?:\/\///' | sed 's~/[a-z]*~~g')
  cutycapt --url=$line --out="shots/$screenshot".png --min-height=800
  echo "Screenshot taken for url: $line"
done < alivedomains.txt
