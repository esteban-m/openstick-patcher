#!/bin/bash

fname="uz801_v2.1_debian"

echo "=== Download initial.bin ==="
wget https://github.com/Mio-sha512/openstick-stuff/releases/download/Firmware/$fname.zip

echo "=== Extract initial.bin ==="
unzip -o $fname.zip -d $fname/

echo "=== Move initial.bin to root directory ==="
mv $fname/$fname.bin initial.bin

echo "=== Clean temporary files ==="
rm -f $fname.zip
rm -rf $fname/

echo "=== Done ==="