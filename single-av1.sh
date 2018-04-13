#!/bin/bash

filename=$1

aomenc  \
${filename} \
--passes=1 --pass=1 \
--fps=24/1 \
--end-usage=cq \
--target-bitrate=512  \
--width=640 --height=360 \
-o ${filename}-av1.webm
