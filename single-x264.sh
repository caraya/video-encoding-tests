#!/bin/bash

filename=$1

ffmpeg -i ${filename} \
-c:v libx264 -preset slow -crf 22 \
-c:a copy -b:a 9k \
${filename}-h264.mp4
