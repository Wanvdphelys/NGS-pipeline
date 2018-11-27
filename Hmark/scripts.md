## Odd scripts

Calling hotspot region with pinellolab/haystack_bio on H3K9me3 merged bamfiles:

```bash
haystack_hotspots sample_name.txt mm10 --output_directory output --chrom_exclude '_|chrM' \
--n_processes 30 --blacklist /home/ycli/data1/MACS/blacklist/mm10.blacklist.bed --do_not_recompute
```

sample_name.txt:
```
LSK	K9_LSK_merge.bam
LGMP	K9_LGMP_merge.bam
GMP	K9_GMP_merge.bam
ckit	K9_c_kit_merge.bam
```

