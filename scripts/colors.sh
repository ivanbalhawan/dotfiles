#!/bin/bash

for m in {0..9}; do
    for i in {0..9}; do
        for C in {30..37}; do
            echo -en "\033[${i};${m};${C}m"
            printf "e[%2d;%2d;%3d" ${i} ${m} ${C}
            echo -en "\033(B\033[m "
        done
        echo
        for C in {90..97}; do
            echo -en "\033[${i};${m};${C}m"
            printf "e[%2d;%2d;%3d" ${i} ${m} ${C}
            echo -en "\033(B\033[m "
        done
        echo
    done
    echo
done
echo

for m in {0..9}; do
    for i in {0..9}; do
        for C in {40..47}; do
            echo -en "\033[${i};${m};${C}m"
            printf "e[%2d;%2d;%3d" ${i} ${m} ${C}
            echo -en "\033(B\033[m "
        done
        echo
        for C in {100..107}; do
            echo -en "\033[${i};${m};${C}m"
            printf "e[%2d;%2d;%3d" ${i} ${m} ${C}
            echo -en "\033(B\033[m "
        done
        echo
    done
    echo
done
echo
# for m in {0..1}; do
# for i in {0..100}; do
# for C in {0..108}; do
#     echo -en "\033[${i};${m};${C}me[$i;${m};$C"
#     echo -en "\033(B\033[m   "
# done
# done
# done
# echo

#for C in {30..38}; do
#    echo -en "\033[38;1;${C}me[38;1;$C"
#    echo -en "\033(B\033[m  "
#done
#echo
#
#for C in {40..48}; do
#    echo -en "\033[38;1;${C}me[38;1;$C"
#    echo -en "\033(B\033[m  "
#done
#echo
#
#for C in {90..98}; do
#    echo -en "\033[38;1;${C}me[38;1;$C"
#    echo -en "\033(B\033[m  "
#done
#echo
#
#for C in {100..108}; do
#    echo -en "\033[38;1;${C}me[38;1;$C"
#    echo -en "\033(B\033[m "
#done
#echo

echo -e "\033(B\033[m"
