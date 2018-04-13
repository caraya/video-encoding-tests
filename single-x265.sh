#!/usr/bin/env bash

filename=$1

ffmpeg -i ${filename} \
-preset slow \
-c:v libx265 -crf 28 \
-c:a aac -b:a 44.1k \
${filename}-h265.mp4
