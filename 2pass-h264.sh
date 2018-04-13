#!/usr/bin/env bash
# Assign filename to the first parameter
filename=$1

# Encode x264
# Pass 1
ffmpeg -i ${filename} \
-preset slow -crf 22 \
-c:v libx264 -b:v 512k \
-pass 1 \
-c:a aac -b:a 128k \
-f mp4 /dev/null

ffmpeg -i ${filename} \
-c:v libx264 -b:v 512k \
-preset slow -crf 22 \
-pass 2 \
-c:a aac -b:a 128k \
${filename}_2pass_h264.mp4
