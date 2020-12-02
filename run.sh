#!/bin/sh

cat logo.txt &&
  cat version.txt && printf " (" && cat version_code.txt && printf ")"
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

    download_destination=$(cat "$image_location_settings")/Compressed
    image_location=$(cat "$image_location_settings")/Uncompressed

    if ! test -e "$download_destination"; then
      if ! mkdir -p "$download_destination"; then

        echo "ERROR: $download_destination was not created"
        exit 1
      fi
    fi

    if ! test -e "$image_location"; then
      if ! mkdir -p "$image_location"; then

        echo "ERROR: $image_location was not created"
        exit 1
      fi
    fi

    if test -e "$image_location"; then

      echo "Images location search path: $image_location"
      parent="$(dirname "$image")"
      if ! mkdir -p "$parent"; then

        echo "ERROR: $parent directory could not be created"
        exit 1
      fi

      system=$(basename "$image")
      obtain_image="$image_location/$system"

      echo "Looking for image: $obtain_image"
      if test -e "$obtain_image"; then

        echo "$obtain_image: Found, deploying to: $image"
      else
        if test -e "$image_provider_settings"; then

          provider_url=$(cat "$image_provider_settings")
          url="$provider_url/Images/Parallels/$system.tar.gz"
          compressed_image="$download_destination/$system.tar.gz"
          if ! test -e "$compressed_image"; then

            echo "WARNING: $obtain_image has not been found"
            echo "Downloading: $system to $obtain_image"

            if wget -P "$download_destination" "$url"; then

              echo "Image downloaded"
            else

              echo "ERROR: Image download failed"
              exit 1
            fi
          else

            echo "Compressed image is already available: $compressed_image"
          fi

          destination="$image_location/$system"
          if ! test -e "$destination"; then
            if ! mkdir -p "$destination"; then

              echo "ERROR: $destination directory not created"
              exit 1
            fi
          fi

          echo "Uncompressing image"
          if tar -xf "$download_destination/$system.tar.gz" -C "$destination"; then

            echo "Image is ready"
          else

            echo "ERROR: Could not extract image"
            exit 1
          fi
        else

          echo "ERROR: $image_provider_settings not available, please create file and add images server url to it"
          exit 1
        fi
      fi

      if cp -a "$obtain_image" "$image"; then

        echo "$obtain_image deployed to: $image"
      else

        echo "$obtain_image was not deployed to: $image"
        exit 1
      fi
    else

      echo "ERROR: $image_location images location search path does not exist"
      exit 1
    fi
  else

    echo "ERROR: $image_location_settings not available, please create file and add absolute path to images to it"
    exit 1
  fi
fi

echo "Please provide your 'sudo' credentials to run Parallels virtual machine"
if sudo python set_machine_name.py "$image"; then

  if ! prlctl list -a -i | grep "$image" >/dev/null 2>&1; then

    prlctl register "$image"
  else

    echo "The VM has been already registered"
  fi

  if prlctl start "$(python get_machine_id.py "$image")"; then

    if ! open -a "Parallels Desktop"; then

      echo "ERROR: could not start 'Parallels Desktop'"
      exit 1
    fi
  else

    echo "ERROR: $image could not start"
    exit 1
  fi
else

  echo "ERROR: $image cannot setup machine name"
  exit 1
fi
