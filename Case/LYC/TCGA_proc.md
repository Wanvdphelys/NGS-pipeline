Process and annotate TCGA RNA-seq data
=======

```R
library(SummarizedExperiment)
library(TCGAbiolinks)

# loading data from downloaded data
# extract assays
hnsc_fpkm_uq <- assay(data)

# annotate with ENSDB
# extract transcripts annotations
ensdb.hs <- EnsDb.Hsapiens.v86
tx.hs <- transcripts(ensdb.hs,return.type = "DataFrame")
tx.hs <- tx.hs[,c("tx_id", "gene_id")]

# extract genes annotations
gene.hs <- genes(ensdb.hs, return.type = 'DataFrame')
gene.hs <- gene.hs[,c('gene_id', 'symbol', 'entrezid', 'gene_biotype')]

# merge tx and gene annotations by gene_id
tx2gene.hs <- merge(tx.hs, gene.hs, by = 'gene_id')
tx2gene.hs <- tx2gene.hs[,c('tx_id', 'gene_id', 'symbol', 'entrezid', 'gene_biotype')]

# clean mem
rm(tx.hs, gene.hs, tx2gene.hs, ensdb.hs)

```
