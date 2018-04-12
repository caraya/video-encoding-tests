#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Encodes a file using best known settings (slow!)"
  echo "  Usage:    be [FILE] [BITRATE]"
  echo "  Example:  be akiyo_cif.y4m 200"
  exit
fi

f=$1  # file is first parameter
b=$2  # bitrate is second parameter

aomenc \
  $f \
  -o $f-$b.av1.webm \
  --codec=av1 \
  --width=640 \
  --height=360 \
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
  --bias-pct=100 \
  --minsection-pct=0 \
  --maxsection-pct=800
