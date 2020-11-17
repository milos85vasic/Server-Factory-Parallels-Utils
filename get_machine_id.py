#!/usr/bin/python
import sys


def main():
    if len(sys.argv) > 0:
        image = sys.argv[0]

    else:
        print "No image path provided"
        sys.exit(1)


if __name__ == "__main__":
    main()
