filename=$1

ffmpeg -y -i ${filename} \
-c:v libx265 -b:v 512k \
-x265-params pass=1 \
-c:a aac -b:a 128k \
-f mp4 null

ffmpeg -i ${filename} \
-c:v libx265 -b:v 512k \
-x265-params pass=2 \
-c:a aac -b:a 128k \
${filename}-2pass-x265.mp4
