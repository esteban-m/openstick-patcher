#!/bin/bash

echo "=== Retrieve latest patch ==="
zipurl=$(curl -s https://api.github.com/repos/esteban-m/openStick-builder/commits/debian | jq -r '.sha' | xargs -I {} echo "https://github.com/esteban-m/openStick-builder/releases/download/build-{}/openstick-debian.zip")
echo "ZIP URL: $zipurl"

echo "=== Download patch ==="
wget $zipurl -O patch.zip

echo "=== Extract patch ==="
unzip -o patch.zip -d patch/

echo "=== Clean temporary files ==="
rm -f patch.zip 2>/dev/null

echo "=== Done ==="