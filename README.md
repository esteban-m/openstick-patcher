# OpenStick Patcher

This repository contains firmware patches and stock firmware files for OpenStick devices.

## Repository Structure

- `patch/` - Contains firmware patch files (.mbn and .bin)
- `stock/` - Contains stock firmware files for different device variants
  - `ufi001b/` - UFI001B variant firmware
  - `uz801/` - UZ801 variant firmware
- `*.sh` - Shell scripts for downloading, updating, and uploading patches

## Large Files

Due to GitHub's file size limitations, the `initial.bin` file (3.9GB) is not included in this repository. This file contains the initial firmware image and should be obtained separately.

### How to obtain initial.bin

1. Download from the official source or your device manufacturer
2. Place it in the repository root directory
3. The file will be ignored by Git (see `.gitignore`)

## Git LFS

This repository uses Git Large File Storage (LFS) to handle binary files efficiently. The following file types are tracked with LFS:

- `*.mbn` files (firmware modules)
- Specific large `.bin` files (excluding `initial.bin`)

## Usage

Refer to the shell scripts for patching operations:

- `download_stock.sh` - Download stock firmware
- `update_patch.sh` - Update patch files
- `upload_patch.sh` - Upload patches to device

## File Sizes

- `patch/rootfs.bin` - ~394 MB (tracked with LFS)
- `stock/*/modem.bin` - ~67 MB each (tracked with LFS)
- `initial.bin` - ~3.9 GB (excluded from repository)
