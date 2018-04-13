#!/usr/bin/env bash

if [[ $# -ne 2 ]]; then
  echo "Encodes a file using best known settings (slow!)"
  echo "  Usage:    be [FILE] [BITRATE]"
  echo "  Example:  be akiyo_cif.y4m 200"
  exit
fi

f=$1  # file is first parameter
b=$2  # bitrate is second parameter

if [[ -e $f.fpf ]]; then
  # First-pass file found, do second pass only
  aomenc \
    $f \
    -o $f-$b.av1.webm \
    --width=640 \
    --height=360 \
    -p 2 \
    --pass=2 \
    --fpf=$f.fpf \
    --cpu-used=2 \
    --target-bitrate=$b \
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
else
  # No first-pass file found, do 2-pass encode
  aomenc \
    $f \
    -o $f-$b.av1.webm \
    --width=640 \
    --height=360 \
    -p 2 \
    --pass=1 \
    --fpf=$f.fpf \
    --cpu-used=2 \
    --target-bitrate=$b \
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

  aomenc \
    $f \
    -o $f-$b.av1.webm \
    --width=640 \
    --height=360 \
    -p 2 \
    --pass=2 \
    --fpf=$f.fpf \
    --cpu-used=2 \
    --target-bitrate=$b \
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
fi
