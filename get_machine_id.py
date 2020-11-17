#!/usr/bin/python
import sys
import subprocess


def main():
    if len(sys.argv) > 1:
        image = sys.argv[1]
        output = subprocess.check_output(['prlctl', 'list', '-a', '-i'])
        items = str(output).split("ID:")
        for item in items:
            if "Name:" in item:
                rows = item.strip().split('\\n')
                name = ""
                for row in rows:
                    if "Home:" in row and image in row:
                        print("ROW: ", row)

    else:
        print("No image path provided")
        sys.exit(1)


if __name__ == "__main__":
    main()
