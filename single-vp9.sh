#!/bin/bash

filename=$1

ffmpeg -i ${filename} \
 -c:v libvpx-vp9 \
 -b:v 512K \
 -c:a libopus -b:a 44.1k \
 ${filename}-vp9.webm
