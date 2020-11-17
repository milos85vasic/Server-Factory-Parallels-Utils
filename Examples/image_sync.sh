#!/bin/sh

source=$1
where=$2
user="your_user"
password="your_password"
remote="example.com:some/path/$where"

echo "Synchronizing: $source -> $remote"
sshpass -p "$password" rsync -azP -e 'ssh -p 7722' --delete "$source" "$user@$remote"