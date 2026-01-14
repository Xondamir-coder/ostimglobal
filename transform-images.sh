#!/usr/bin/env bash
# Converts all images in public/images/original into:
#  - AVIF responsive variants (576/1024/1440)
#  - Compressed JPEG/PNG fallbacks (in /compressed)
# Cleaning output folders is NOW OPTIONAL.

set -e

INPUT_DIR="public/images/original"
OUTPUT_DIR="public/images"

SIZES=(
  "576:40%"
  "1024:70%"
  "1440:100%"
)

COMPRESSED_DIR="$OUTPUT_DIR/compressed"

CLEAN_AVIF=false
CLEAN_COMPRESSED=false

# -------------------------------
# Parse Options
# -------------------------------
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --clean)
      CLEAN_AVIF=true
      CLEAN_COMPRESSED=true
      ;;
    --clean-avif)
      CLEAN_AVIF=true
      ;;
    --clean-compressed)
      CLEAN_COMPRESSED=true
      ;;
    --help)
      echo "Usage: ./transform-images.sh [options]"
      echo
      echo "Options:"
      echo "  --clean             Remove ALL output folders before generating"
      echo "  --clean-avif        Remove only 576/1024/1440 folders"
      echo "  --clean-compressed  Remove only /compressed folder"
      echo "  --help              Show this message"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use --help for guidance."
      exit 1
      ;;
  esac
  shift
done

# -------------------------------
# Optional cleaning
# -------------------------------
if [[ "$CLEAN_AVIF" == true ]]; then
  echo "🧹 Cleaning AVIF output folders..."
  for size in "${SIZES[@]}"; do
    folder="${size%%:*}"
    outdir="$OUTPUT_DIR/$folder"
    [ -d "$outdir" ] && rm -rf "$outdir"
  done
fi

if [[ "$CLEAN_COMPRESSED" == true ]]; then
  echo "🧹 Cleaning compressed folder..."
  [ -d "$COMPRESSED_DIR" ] && rm -rf "$COMPRESSED_DIR"
fi

# -------------------------------
# AVIF Generation
# -------------------------------
echo "🖼️ Transforming images from $INPUT_DIR..."

for size in "${SIZES[@]}"; do
  folder="${size%%:*}"
  scale="${size##*:}"
  outdir="$OUTPUT_DIR/$folder"

  mkdir -p "$outdir"

  echo "➡️ Generating ${folder}px AVIF images at $scale..."

  for f in "$INPUT_DIR"/*.{png,PNG,jpg,JPG,jpeg,JPEG}; do
    [ -f "$f" ] || continue
    filename="$(basename "${f%.*}")"
    outfile="$outdir/$filename.avif"

    if [ -f "$outfile" ]; then
      echo "⏭️  Skipping $outfile (already exists)"
    else
      magick "$f" -resize "$scale" "$outfile"
    fi
  done
done


# -------------------------------
# Compressed fallback generation
# -------------------------------
echo "📦 Generating compressed JPEG/PNG fallbacks..."

mkdir -p "$COMPRESSED_DIR"

for f in "$INPUT_DIR"/*.{png,PNG,jpg,JPG,jpeg,JPEG}; do
  [ -f "$f" ] || continue
  filename="$(basename "$f")"
  ext="${filename##*.}"
  out="$COMPRESSED_DIR/$filename"

  if [ -f "$out" ]; then
    echo "⏭️  Skipping $filename (compressed exists)"
  else
    echo "➡️ Compressing $filename..."

    case "$ext" in
      jpg|JPG|jpeg|JPEG)
        magick "$f" -strip -interlace Plane -quality 75 "$out"
        ;;
      png|PNG)
        magick "$f" -strip -define png:compression-level=9 "$out"
        ;;
    esac
  fi
done


echo "✅ All images transformed successfully!"
