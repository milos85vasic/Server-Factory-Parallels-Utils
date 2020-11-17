# Server Factory Parallels Utils

Parallels utils for [Server Factory](https://github.com/milos85vasic/Server-Factory).

## Requirements

To be able to use Parallels Utils the following dependencies must be installed:

- Parallels for your version of macOS
- Python 3

Following settings files have to be created:

- `image_location.settings` defines location on your file system where Parallels images will be stored
- `image_provider.settings` defines base URL for published Parallels images
- `image_sync.sh` defines script for Parallels images publishing (upload)

See examples of each of these files in [Examples](./Examples) directory.

## How to use

There are the following scripts that can be used:

- `publish_images.sh` used to publish your Parallels images to remote endpoint
- `run.sh` used to run your Parallels images

### Publishing images

`image_location.settings` defines location of your images. Directory that is pointed here should have two 
subdirectories:

- Compressed, containing .tar.gz versions of Parallels images
- Uncompressed, containing Parallels images

When you install new system, copy its .pvm file into the 'Uncompressed' directory. Keep separate
directories containing working images and 'matrices'. All contained inside `image_location.settings`
settings directory are matrices. So, for example, your `image_location.settings` can point to:
`/Volumes/Your_Drive/Parallels/Images` directory, while all working images 
(ones that are executed and used in regular work) can be located in:
`/Volumes/Your_Drive/Parallels/Using`. Paths that you will use are absolutely up to you.

Once `publish_images.sh` is executed all Parallels images located under 'Uncompressed' directory will be compressed into
.tar.gz files and moved to 'Compressed' directory. Then, all compressed Parallels images (.tar.gz) will
be uploaded to remote endpoint by triggering `image_sync.sh` script.

Thanks to this you will be able to publish all your Parallels images matrices to the cloud and have them ready for any future use.

### Retrieving and using published images

Tbd.
