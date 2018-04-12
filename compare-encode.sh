#!/bin/bash
#
# Shell script to prepare and encode the videos to go alongside the
# video codec comparison blog post (insert URL here when published)
#
# author: carlos araya (carlos.araya@gmail.com)
# license: MIT (https://caraya.mit-license.org/)

# Assign filename to the first parameter
filename=$1


ffmpeg -i $filename -r 24 -vf format=yuv420p ${filename}-source.y4m

# Encode x264
ffmpeg -i ${filename} \
-c:v libx264 -preset slow -crf 22 \
-c:a aac -b:a 44100 \
${filename}-h264.mp4

# Encode h265 with ffmpeg
ffmpeg -i ${filename} \
-preset slow \
-c:v libx265 -crf 28 \
-c:a aac -b:a 44100 \
${filename}-h265.mp4

# Encode vp9 with ffmpeg
ffmpeg -i ${filename} \
 -c:v libvpx-vp9 \
 -minrate 512K -maxrate 512K  -b:v 512K \
 -c:a libopus -b:a 44100 \
 ${filename}-vp9.webm

# Encode av1 with aomenc
# STILL FINETUNING, Subject to change
aomenc  \
${filename} \
--passes=1 --pass=1 \
--fps=24/1 \
--end-usage=cq \
--target-bitrate=512  \
--width=640 --height=360 \
-o ${filename}-av1.webm


