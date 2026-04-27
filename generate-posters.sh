#!/bin/bash
# Run this after adding new videos to images/ to pre-generate poster frames.
# Usage: bash generate-posters.sh
# After running, change the relevant video's preload attribute from "metadata" to "none" in index.html.

IMAGES_DIR="$(dirname "$0")/images"

for mp4 in "$IMAGES_DIR"/*.mp4; do
  [ -f "$mp4" ] || continue
  name="$(basename "$mp4" .mp4)"
  out="$IMAGES_DIR/poster-${name}.jpg"
  echo "Generating $out ..."
  ffmpeg -y -i "$mp4" -ss 3 -vframes 1 -update 1 -q:v 2 "$out" 2>/dev/null \
    || ffmpeg -y -i "$mp4" -vframes 1 -update 1 -q:v 2 "$out" 2>/dev/null
done

echo "Done. Remember to set preload=\"none\" on videos that now have poster images."
