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

