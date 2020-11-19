#!/usr/bin/python
import sys
import os


def main():
    if len(sys.argv) > 1:
        image = sys.argv[1]
        file_path = image + "/config.pvs"
        if os.path.exists(file_path):
            with open(file_path, 'r') as fp:
                print(file_path + ": Configuration file")

        else:
            print("ERROR: Configuration file was not found")
            sys.exit(1)

    else:
        print("No image path provided")
        sys.exit(1)


if __name__ == "__main__":
    main()
