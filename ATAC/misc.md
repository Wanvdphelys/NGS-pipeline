# Miscellaneous notes for ATAC-seq

* [removing duplicates](https://informatics.fas.harvard.edu/atac-seq-guidelines.html) by picard increases s/n observed
* [removing non-primary chromosome](https://bioinformatics-workbook.readthedocs.io/en/latest/dataAnalysis/ATAC-seq/ATAC_tutorial/) because they will cause "confounding signals":
  * regarding GRCh38: samtools idxstats Ln.sorted.dedup.bam | cut -f1 | grep -v KI | grep -v GL | grep -v MT | xargs samtools view --threads 10 -b sample.bam > clean_sample.bam
* STAR index does not include prefix chr infront of chromosomes, which may cause trouble in some cases. To [add the chr prefix](https://www.biostars.org/p/13462/), use: 
```bash
samtools view -H test.bam | sed -e 's/SN:1/SN:chr1/' | sed -e 's/SN:2/SN:chr2/' | sed -e 's/SN:3/SN:chr3/' | sed -e 's/SN:4/SN:chr4/' | sed -e 's/SN:5/SN:chr5/' | sed -e 's/SN:6/SN:chr6/' | sed -e 's/SN:7/SN:chr7/' | sed -e 's/SN:8/SN:chr8/' | sed -e 's/SN:9/SN:chr9/' | sed -e 's/SN:10/SN:chr10/' | sed -e 's/SN:11/SN:chr11/' | sed -e 's/SN:12/SN:chr12/' | sed -e 's/SN:13/SN:chr13/' | sed -e 's/SN:14/SN:chr14/' | sed -e 's/SN:15/SN:chr15/' | sed -e 's/SN:16/SN:chr16/' | sed -e 's/SN:17/SN:chr17/' | sed -e 's/SN:18/SN:chr18/' | sed -e 's/SN:19/SN:chr19/' | sed -e 's/SN:20/SN:chr20/' | sed -e 's/SN:21/SN:chr21/' | sed -e 's/SN:22/SN:chr22/' | sed -e 's/SN:X/SN:chrX/' | sed -e 's/SN:Y/SN:chrY/' | sed -e 's/SN:MT/SN:chrM/' | samtools reheader - test.bam > test_chr.bam
```
* shift bamfile: [alignmentSieve](https://deeptools.readthedocs.io/en/develop/content/tools/alignmentSieve.html) using --ATACshift option
  * Note: If the --shift or --ATACshift options are used, then only properly-paired reads will be used.
