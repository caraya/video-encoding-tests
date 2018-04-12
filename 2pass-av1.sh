filename=$1

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
