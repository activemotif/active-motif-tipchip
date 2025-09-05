#!/usr/bin/env bash
set -euo pipefail

# Usage message
usage() {
  echo "Usage: $0 -i R1.fastq.gz R2.fastq.gz -m metadata.tsv [-o output_dir] [-x max_mismatches] [-d min_mismatch_delta]"
  exit 1
}

# Default values
OUTPUT_DIR="FASTQ_Output"
MAX_MISMATCHES=1
MIN_MISMATCH_DELTA=1

# Parse arguments
while getopts ":i:m:o:x:d:" opt; do
  case $opt in
    i) 
      # input files (expecting two fastqs: R1 and R2)
      INPUTS="$OPTARG"
      shift $((OPTIND-1))
      INPUTS="$INPUTS $1"
      ;;
    m) METADATA="$OPTARG" ;;
    o) OUTPUT_DIR="$OPTARG" ;;
    x) MAX_MISMATCHES="$OPTARG" ;;
    d) MIN_MISMATCH_DELTA="$OPTARG" ;;
    *) usage ;;
  esac
done

# Check required arguments
if [[ -z "${INPUTS:-}" || -z "${METADATA:-}" ]]; then
  usage
fi

# Run fqtk demux
echo "Running fqtk demux..."
conda run fqtk demux \
  --inputs $INPUTS \
  --read-structures 6B19S+T 6B19S+T \
  --sample-metadata "$METADATA" \
  --output "$OUTPUT_DIR" \
  --output-types T \
  --max-mismatches "$MAX_MISMATCHES" \
  --min-mismatch-delta "$MIN_MISMATCH_DELTA"
