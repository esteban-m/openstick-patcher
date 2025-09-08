# OpenStick Patcher

This repository contains firmware patches and stock firmware files for OpenStick devices. It provides a complete workflow for downloading, patching, and flashing OpenStick firmware with custom distributions.

## Repository Structure

- `patch/` - Contains firmware patch files (.mbn and .bin) for custom distributions
- `stock/` - Contains stock firmware files for different device variants
  - `ufi001b/` - UFI001B variant firmware
  - `uz801/` - UZ801 variant firmware
- `*.sh` - Shell scripts for the complete patching workflow

## Workflow Overview

The patching process follows a specific sequence to ensure everything works correctly:

→ 1. **Download Initial Image** → 2. **Backup Stock Partitions** → 3. **Update Patches** → 4. **Flash Everything**

## Scripts Usage

### 1. `download_initial.sh`
Downloads a complete firmware image with all necessary patches to ensure nothing breaks.

```bash
./download_initial.sh
```

**What it does:**
- Downloads the latest `uz801_v2.1_debian` firmware from GitHub releases [(Mio-sha512/openstick-stuff)](https://github.com/Mio-sha512/openstick-stuff/releases/tag/Firmware)
- Extracts and renames the image to `initial.bin`
- Places it in the repository root directory
- Cleans up temporary files

**When to use:** Always start here to get a working base image.

### 2. `download_stock.sh`
Creates a backup of important stock partitions for new motherboard variants.

```bash
./download_stock.sh
```

**What it does:**
- Prompts for a folder name (e.g., `ufi001b`, `uz801`)
- Creates a new directory in `stock/` for the device variant
- Downloads critical partitions via EDL (Emergency Download Mode):
  - `fsc.bin` - File System Cache
  - `fsg.bin` - File System Guard
  - `modem.bin` - Modem firmware
  - `modemst1.bin` - Modem state 1
  - `modemst2.bin` - Modem state 2
  - `persist.bin` - Persistent data
  - `sec.bin` - Security data

**When to use:** When you have a new motherboard variant that needs its stock partitions backed up.

### 3. `update_patch.sh`
Updates patch files from the openStick-builder repository when you've modified your image.

```bash
./update_patch.sh
```

**What it does:**
- Fetches the latest commit SHA from the openStick-builder repository
- Downloads the latest patch ZIP file from GitHub releases
- Extracts patch files to the `patch/` directory
- Cleans up temporary files

**When to use:** After modifying your image with new packages, distributions, or system changes.

### 4. `upload_patch.sh`
Flashes everything to the device in the correct order.

```bash
./upload_patch.sh
```

**What it does:**
- Uploads the clean `initial.bin` image via EDL
- Flashes the `aboot` patch and reboots to fastboot mode
- Automatically detects the board model
- Flashes all patch files (partition table, bootloader, kernel, rootfs)
- Flashes stock partitions for the detected model
- Performs final reboot

**When to use:** Final step to flash everything to your OpenStick device.

## Prerequisites

- **EDL (Emergency Download Mode)** - For initial flashing and stock partition backup
- **Fastboot** - For patch flashing
- **wget** - For downloading files
- **unzip** - For extracting archives
- **jq** - For parsing JSON from GitHub API
- **curl** - For API requests

1. **Install EDL from [this repo (bkerler/edl)](https://github.com/bkerler/edl)**

2. Install adb, fastboot, wget, unzip, jq, curl
```bash
sudo apt install adb fastboot wget unzip jq curl
```


## Large Files

Due to GitHub's file size limitations, the `initial.bin` file (3.9GB) is not included in this repository. Use `download_initial.sh` to obtain it automatically.

## Git LFS

This repository uses Git Large File Storage (LFS) to handle binary files efficiently. The following file types are tracked with LFS:

- `*.mbn` files (firmware modules)
- Specific large `.bin` files (excluding `initial.bin`)

## File Sizes

- `patch/rootfs.bin` - ~394 MB (tracked with LFS)
- `stock/*/modem.bin` - ~67 MB each (tracked with LFS)
- `initial.bin` - ~3.9 GB (excluded from repository, use `download_initial.sh`)
