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

        echo "WARNING: $obtain_image has not been found"
        echo "Downloading: $system to $obtain_image"

        if test -e "$image_provider_settings"; then

          provider_url=$(cat "$image_provider_settings")
          url="$provider_url/Images/Parallels/$system"
          download_destination="/tmp"
          if wget -P "$download_destination" "$url"; then

            echo "Image downloaded"
            echo "Extracting image to: $image_location"
            if ! test -e "$image_location"; then

              if mkdir -p "$image_location"; then

                echo "$image_location: Directory created"
              else

                echo "ERROR: $image_location directory not created"
                exit 1
              fi
            fi
            if tar -xf "$download_destination/$system" -C "$image_location"; then

              echo "Image is ready"
            else

              echo "ERROR: Could not extract image"
              exit 1
            fi
          else

            echo "ERROR: Image download failed"
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

# TODO: Run machine