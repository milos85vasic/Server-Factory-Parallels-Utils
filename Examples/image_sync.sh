#!/bin/sh

source=$1
where=$2
user="statics.1.v1"
password="StaticFnt@stIcZ1996"
remote="red-elf.com:Content/www.red-elf.com/$where"

echo "Synchronizing: $source -> $remote"
sshpass -p "$password" rsync -azP -e 'ssh -p 7722' --delete "$source" "$user@$remote"