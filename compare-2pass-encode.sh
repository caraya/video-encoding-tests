#!/bin/bash
#
# Shell script to prepare and encode the 2-pass videos to go alongside the
# video codec comparison blog post (insert URL here when published)
#
# author: carlos araya (carlos.araya@gmail.com)
# license: MIT (https://caraya.mit-license.org/)

# Assign filename to the first parameter
filename=$1

# Encode x264
# Pass 1
ffmpeg -y -i ${filename} \
-preset slow -crf 22 \
-c:v libx264 -b:v 512k \
-pass 1 \
-c:a aac -b:a 128k \
-f mp4 /dev/null

ffmpeg -y -i ${filename} \
-c:v libx264 -b:v 512k \
-preset slow -crf 22 \
-pass 2 \
-c:a aac -b:a 128k \
${filename}_2pass_h264.mp4

# Encode x265
# Pass 1
ffmpeg -y -i ${filename} \
-c:v libx265 -b:v 512k \
-x265-params pass=1 \
-c:a aac -b:a 128k \
-f mp4 null

# Pass 2
ffmpeg -y -i ${filename} \
-c:v libx265 -b:v 512k \
-x265-params pass=2 \
-c:a aac -b:a 128k \
${filename}-2pass-x265.mp4

# VP 9
# Pass 1
ffmpeg -y -i ${filename} \
-c:v libvpx-vp9 -b:v 512K \
-pass 1 -c:a libopus \
-f webm null

# Pass 2
ffmpeg -y -i ${filename} \
-c:v libvpx-vp9 -b:v 512K \
-pass 2 -c:a libopus \
${filename}_2pass_vp9.webm

# AV1
# AV1 Pass 1
  aomenc \
    $f \
    -o $f-av1-2pass.webm \
    --width=640 \
    --height=360 \
    -p 2 \
    --pass=1 \
    --fpf=$f.fpf \
    --cpu-used=2 \
    --target-bitrate=512K \
    --auto-alt-ref=1 \
    -v \
    --minsection-pct=0 \
    --maxsection-pct=800 \
    --lag-in-frames=25 \
    --kf-min-dist=0 \
    --kf-max-dist=99999 \
    --static-thresh=0 \
    --min-q=0 \
    --max-q=63 \
    --drop-frame=0
# AV1 Pass 2
  aomenc \
    $f \
    $f-av1-2pass.webm  \
    --width=640 \
    --height=360 \
    -p 2 \
    --pass=2 \
    --fpf=$f.fpf \
    --cpu-used=2 \
    --target-bitrate=512K \
    --auto-alt-ref=1 \
    -v \
    --minsection-pct=0 \
    --maxsection-pct=800 \
    --lag-in-frames=25 \
    --kf-min-dist=0 \
    --kf-max-dist=99999 \
    --static-thresh=0 \
    --min-q=0 \
    --max-q=63 \
    --drop-frame=0 \
    --bias-pct=0 \
    --minsection-pct=0 \
    --maxsection-pct=800 \
    --psnr \
    --arnr-maxframes=7 \
    --arnr-strength=3

