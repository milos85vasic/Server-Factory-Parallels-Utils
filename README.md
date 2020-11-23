# [Server Factory](https://github.com/milos85vasic/Server-Factory) [Parallels](https://www.parallels.com/) Utils

[Parallels](https://www.parallels.com/) utils for [Server Factory](https://github.com/milos85vasic/Server-Factory).

Toolkit can be used as a part of [Server Factory](https://github.com/milos85vasic/Server-Factory) projects or
completely independently. Main goal of this toolkit is to provide the following:

- Mechanism for compression and synchronization of [Parallels](https://www.parallels.com/) images
(matrices of systems used for development and testing)
- Mechanism for retrieving all published [Parallels](https://www.parallels.com/) images and further use
on multiple computers (working stations, servers etc).

[![Parallels Utils Video tutorial](https://i.imgur.com/6Xs1vf6.png)](https://www.youtube.com/watch?v=7raTkPZaYxQ)

## Requirements

To be able to use [Parallels](https://www.parallels.com/) Utils the following dependencies must be installed:

- [Parallels](https://www.parallels.com/) for your version of macOS
- Python 3

Following settings files have to be created:

- `image_location.settings` defines location on your file system where [Parallels](https://www.parallels.com/) images will be stored
- `image_provider.settings` defines base URL for published [Parallels](https://www.parallels.com/) images
- `image_sync.sh` defines script for [Parallels](https://www.parallels.com/) images publishing (upload)

See examples of each of these files in [Examples](./Examples) directory.

## How to use

The following scripts can be used for work with [Parallels](https://www.parallels.com/) images (and virtual machines):

- `publish_images.sh` used to publish your [Parallels](https://www.parallels.com/) images to remote endpoint
- `run.sh` used to run your [Parallels](https://www.parallels.com/) images (virtual machines)

### Publishing images

`image_location.settings` defines location of your images. Directory that is pointed here should have two 
subdirectories:

- 'Compressed', used to contain .tar.gz versions of [Parallels](https://www.parallels.com/) images
- 'Uncompressed', used to contain [Parallels](https://www.parallels.com/) images (.pvm)

When you install new system, copy its .pvm file into the 'Uncompressed' directory. Keep separate
directories containing working images (virtual machines) and 'matrices'. All contained inside the directory 
defined in  `image_location.settings` are matrices. So, for example, your 
`image_location.settings` can point to: `/Volumes/Your_Drive/Parallels/Images` directory, 
while all working images  (ones that are executed and used in regular work) can be located in:
`/Volumes/Your_Drive/Parallels/Using`. Paths that you will use are absolutely up to you.

Once `publish_images.sh` is executed all [Parallels](https://www.parallels.com/) images located under 'Uncompressed' 
directory will be compressed into .tar.gz files and moved to 'Compressed' directory. 
Then, all compressed [Parallels](https://www.parallels.com/) images (.tar.gz) will be uploaded to 
remote endpoint by triggering `image_sync.sh` script.

Thanks to this you will be able to publish all your [Parallels](https://www.parallels.com/) images 
matrices to the cloud and have them ready for any future use on any of your working computers.

### Retrieving and using published images

To run [Parallels](https://www.parallels.com/) image (virtual machine) it is required to execute 
`run.sh` script. Script accepts one argument, absolute path to .pvm file of your image (virtual machine).
Absolute path must point to working version of the image (not the matrix).

If absolute path and file exist [Parallels](https://www.parallels.com/) image will be executed and virtual machine started.
If path (and) file do not exist all directories will be created. Then, the following will happen:

- If 'Uncompressed' version of the image is available, it will be copied to our absolute path and 
[Parallels](https://www.parallels.com/) image will be executed and virtual machine started

- If 'Uncompressed' image is not available, but 'Compressed' one exists, .tar/gz file be uncompressed
into 'Uncompressed' directory and everything from previous point done

- If there is no 'Uncompressed' or 'Compressed' version of the image, .tar.gz file will be downloaded
from the remote endpoint with base URl defined in `image_provider.settings`. After file is downloaded
all from previous point will be done.

## What's new?

To see what is new in a current version please see [changelog](./CHANGELOG.md).