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
# create TF vector
TF_list <- c('ALKBH5,TFIID,NR3C1,YY1,CEBPB,IRF2,GCFC2,TFAP2A,FOXP3,GATA1,Pax5,TP53,ESR1,MYB,PGR,NF1,RXRA,XBP1,TCF4,HOXD9,HOXD10,GTF2I')
TF_list <- unlist(strsplit(TF_list, split = ','))

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

# deal with another platform
GSE37642_97 <- GSE37642$`GSE37642-GPL97_series_matrix.txt.gz`
GSE37642_97_eset <- data.frame(fData(GSE37642_97), exprs(GSE37642_97))
GSE37642_97_eset <- GSE37642_97_eset[,-c(1:10,12:16)]
GSE37642_97_eset <- collapseRows(GSE37642_97_eset[,2:ncol(GSE37642_97_eset)],
                                 rowGroup = GSE37642_97_eset$Gene.Symbol,
                                 rowID = row.names(GSE37642_97_eset))
GSE37642_97_eset <- GSE37642_97_eset$datETcollapsed

# row bind 2 platforms
GSE37642_9697_eset <- rbind(GSE37642_96_eset, GSE37642_97_eset)

# another GEO dataset
GSE14468 <- getGEO('GSE14468', destdir = 'C:\\Users\\wanvdphelys\\Desktop\\Zhanglab\\Wang Jiazhen\\promoter-TF')
GSE14468_eset <- GSE14468$GSE14468_series_matrix.txt.gz
GSE14468_eset <- data.frame(fData(GSE14468_eset), exprs(GSE14468_eset))
GSE14468_eset <- GSE14468_eset[,-c(1:10,12:16)]
GSE14468_eset <- collapseRows(GSE14468_eset[,2:ncol(GSE14468_eset)],
                              rowGroup = GSE14468_eset$Gene.Symbol,
                              rowID = row.names(GSE14468_eset))
GSE14468_eset <- GSE14468_eset$datETcollapsed

# create correlation plot
library(corrplot)

# selecting TF and target gene
GSE37642_9697_eset_corr <- GSE37642_9697_eset[row.names(GSE37642_9697_eset) %in% TF_list,]
# remove duplication
GSE37642_9697_eset_corr <- GSE37642_9697_eset_corr[!duplicated(row.names(GSE37642_9697_eset_corr)),]
# compute correlation matrix 
corr_GSE37642_9697 <- cor(t(GSE37642_9697_eset_corr))
# calculate multi-test p value
res_GSE37642_9697_eset <- cor.mtest(GSE37642_9697_eset_corr, conf.level = .95)
# plot correlation matrix
corrplot(corr_GSE37642_9697, p.mat = res_GSE37642_9697_eset$p, method = "ellipse", cl.lim = c(-100, 100))
```
