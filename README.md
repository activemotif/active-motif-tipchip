# active-motif-tipchip

This repository provides a wrapper script for demultiplexing **TIP-ChIP** sequencing data. The script accepts paired-end FASTQ files, inline barcode metadata, and configurable parameters for barcode mismatches and trimming.

---

## 📦 Installation

### 1) Install `conda` (if not already installed)
We recommend [Miniconda](https://docs.conda.io/en/latest/miniconda.html).

### 2) Install [`fqtk`](https://github.com/fulcrumgenomics/fqtk)
```bash
conda install -c bioconda fqtk
```

### 3) Clone this repository
```bash
git clone https://github.com/activemotif/active-motif-tipchip.git
cd active-motif-tipchip
chmod +x bin/run_demux_tipchip.sh
```

---

## 🚀 Usage

The wrapper script is located at `bin/run_demux_tipchip.sh`, run it with:

```bash
bash run_demux_tipchip.sh -i R1.fastq.gz R2.fastq.gz -m metadata.tsv [options]
```

### Required arguments
- `-i R1.fastq.gz R2.fastq.gz` → paired-end FASTQ files  
- `-m metadata.tsv` → inline barcode metadata file  

### Optional arguments
- `-o OUTPUT_DIR` → output directory (default: `FASTQ_Output`)  
- `-x MAX_MISMATCHES` → maximum mismatches (default: `1`)  
- `-d MIN_MISMATCH_DELTA` → minimum mismatch delta (default: `1`)  

---

## 📝 Example

```bash
bash run_demux_tipchip.sh \
-i sample1_r1.fastq.gz sample1_r2.fastq.gz \
-m inlinebarcode_metadata.tsv \
-o demux_results
```

This will demultiplex reads using inline barcodes and write outputs to `demux_results`.

---

## 📂 Output

Demultiplexed FASTQs are written to the specified output directory. Each sample defined in the metadata file will have its own FASTQ files.

---

## 🔧 Notes

- The default read structure in the script is `6B19S+T 6B19S+T`, consistent with TIP-ChIP libraries.  
- Adjust parameters if your experimental design differs.  
- For advanced usage and full parameter descriptions, refer to the official [fqtk documentation](https://github.com/fulcrumgenomics/fqtk).
