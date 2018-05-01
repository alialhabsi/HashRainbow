#!/bin/bash 

passwordfile="hackpair.pwd"
password1_toCompare=""
hash1_toCompare=""
password1=""
password2_toCompare=""
hash2_toCompare=""
password2=""

while IFS= read -r line
do
	hashes="$line"

done < "$passwordfile"
hash_1=${hashes:0:34}
salt_1=${hashes:3:8}
hash_2=${hashes:35}
salt_2=${hashes:38:8}
COUNTER=0
echo "salt for hash1: $salt_1"
echo "hash1 value: $hash_1"
echo "salt for hash2: $salt_2"
echo "hash2 value: $hash_2"


  for c1 in {A..Z} {a..z} {0..9};do
    if [ "$hash1_toCompare" == "$hash_1" ];then
    break
    fi
    for c2 in {A..Z} {a..z} {0..9};do
    if [ "$hash1_toCompare" == "$hash_1" ];then
    break
    fi
      for c3 in {A..Z} {a..z} {0..9};do
        password1_toCompare="$c1$c2$c3"
        hash1_toCompare=$(mkpasswd -m MD5 "$password1_toCompare" -s "$salt_1")
        COUNTER=$((COUNTER + 1))	
        echo "Brute forcing: $password1_toCompare ...................$COUNTER"
        echo "The hash is: $hash1_toCompare"
        if [ "$hash1_toCompare" == "$hash_1" ]; then
          echo "Password found for first hash!, the password is: $password1_toCompare"
          break
        fi 	
      done 
    done	
  done

echo "Attempting to brute force second hash:"
echo "======================================"

for c1 in {A..Z} {a..z} {0..9};do
    for c2 in {A..Z} {a..z} {0..9};do
      for c3 in {A..Z} {a..z} {0..9};do
        password2_toCompare="$c1$c2$c3"
        hash2_toCompare=$(mkpasswd -m SHA-512 "$password2_toCompare" -s "$salt_2")
        COUNTER=$((COUNTER + 1))	
        echo "Brute forcing: $password2_toCompare ...................$COUNTER"
        echo "The hash is: $hash2_toCompare"
        if [ "$hash2_toCompare" == "$hash_2" ]; then
          echo "Password found for second hash!, the password is: $password2_toCompare"
          exit 1
        fi 	
      done 
    done	
  done
