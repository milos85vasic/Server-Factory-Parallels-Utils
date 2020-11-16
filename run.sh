#!/bin/sh

cat logo.txt && \
cat version.txt
echo ""

image=$1
echo "Checking system image availability"

if test -e "$image"; then

  echo "$image: Is ready"
else

  echo "$image: Is not available"
  echo "$image: Obtaining"
  image_location_settings="image_location.settings"
  image_provider_settings="image_provider.settings"
  if test -e "$image_location_settings"; then

    image_location=$(cat "$image_location_settings")/Uncompressed
  else

    echo "ERROR: $image_location_settings not available, please create file and add absolute path to images to it"
    exit 1
  fi
fi

# TODO: Run machine