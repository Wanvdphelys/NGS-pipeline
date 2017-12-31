Predict transcription factor of A5 based on PROMO and correlation analysis
===========

### 1 get sequence 2000 bp upstream and 100 bp down stream transcription start site(TSS) form UCSC genome browser - GRCh38

### 2 predict transcription factor based on TF-binding site motifs on PROMO
PROMO: http://alggen.lsi.upc.es/cgi-bin/promo_v3/promo/promoinit.cgi?dirDB=TF_8.3 </br>
Maximum matrix dissimilarity rate: 0 </br>
**results:**
TFIID, GR, YY1, C/EBPbeta, GR-alpha, GR-beta, IRF-2, GCF, AP-2alphaA, FOXP3, GATA-1, Pax-5, p53, ER-alpha, c-Myb, PR B, PR A, NF-1, RXR-alpha, XBP-1, TCF-4E, HOXD9, HOXD10, C/EBPalpha, TFII-I
### 3 corelation analysis in TCGA and GEO datasets
**data source:** 
- TCGA-LAML_FPKM_UQ_Transcriptome_Profiling_Gene_Expression_Quantification_hg38
- GSE37642 984 AML patients  https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE37642
- GSE14468 526 AML patients  https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE14468
```R
# loading GEO datasets as GSE format
library(GEOquery)
library(WGCNA)

# download GEO dataset
GSE37642 <- getGEO('GSE37642', destdir = 'C:\\Users\\wanvdphelys\\Desktop\\Zhanglab\\Wang Jiazhen\\promoter-TF')
# tidy it up
GSE37642_96 <- GSE37642$`GSE37642-GPL96_series_matrix.txt.gz`
# create expression matrix
GSE37642_96_eset <- data.frame(fData(GSE37642_96), exprs(GSE37642_96))
GSE37642_96_eset <- GSE37642_96_eset[,-c(1:10,12:16)]

# summarize transcripts to gene level
GSE37642_96_eset <- collapseRows(GSE37642_96_eset[,2:ncol(GSE37642_96_eset)],
                                 rowGroup = GSE37642_96_eset$Gene.Symbol,
                                 rowID = row.names(GSE37642_96_eset))
GSE37642_96_eset <- GSE37642_96_eset$datETcollapsed
```
