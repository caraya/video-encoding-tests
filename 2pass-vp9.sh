
# Assign filename to the first parameter
filename=$1

# Pass 1
ffmpeg -i ${filename} \
-c:v libvpx-vp9 -b:v 512K \
-pass 1 -c:a libopus \
-f webm null

# Pass 2
ffmpeg -i ${filename} \
-c:v libvpx-vp9 -b:v 512K \
-pass 2 -c:a libopus \
${filename}_2pass_vp9.webm
