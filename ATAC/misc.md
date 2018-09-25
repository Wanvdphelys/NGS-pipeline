# Miscellaneous notes for ATAC-seq

* [removing duplicates](https://informatics.fas.harvard.edu/atac-seq-guidelines.html) by picard increases s/n observed
* [removing non-primary chromosome](https://bioinformatics-workbook.readthedocs.io/en/latest/dataAnalysis/ATAC-seq/ATAC_tutorial/) because they will cause "confounding signals":
  * regarding GRCh38: samtools idxstats Ln.sorted.dedup.bam | cut -f1 | grep -v KI | grep -v GL | grep -v MT | xargs samtools view --threads 10 -b sample.bam > clean_sample.bam
