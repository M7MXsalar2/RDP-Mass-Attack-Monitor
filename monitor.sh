#!/bin/sh

cat attack-output.out | grep '\[3389\]' > formatted-output.out

printf "\e[7mRDP Servers Successfully Authenticated:\e[0m"
printf "\e[32m\e[1m " && wc -l < formatted-output.out && printf "\e[0m"
printf '\n\e[4m10 Latest entries of formatted-output.out:\e[0m\n'
tail -10 formatted-output.out
printf '\n\e[4mAlready tested IP Ranges:\e[0m'
printf "\e[32m\e[1m " && ls "data-tested/" | wc -l && printf "\e[0m"
ls -C "data-tested/" | tail -10

printf '\n\e[4mIP ranges left to test:\e[0m'
printf "\e[32m\e[1m " && ls "data/" | wc -l && printf "\e[0m"
ls -C "data/"
