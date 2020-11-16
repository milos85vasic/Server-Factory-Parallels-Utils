#!/bin/sh

cat logo.txt && \
cat version.txt

machine=$1
echo "Checking system image availability"

if test -e "$machine"; then

  echo "$machine: Is ready"
else

  # TODO
  echo "TODO"
fi

# TODO: Run machine