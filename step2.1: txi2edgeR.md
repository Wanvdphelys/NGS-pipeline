Analyzing gene level quantification data with edgeR
======================================

### 1. Load in data into edgeR

passing read counts and transcript length to edgeR. If scaled data (eg. TPM) is used, length is no longer needed.

```R
library(edgeR)

cts <- txi.kallisto.tsv$counts
normMat <- txi.kallisto.tsv$length
normMat <- normMat/exp(rowMeans(log(normMat)))

# normalize for 1. gene length, 2. seq depth and 3. effective library size
# this offset can replace all edgeR internal normalization
o <- log(calcNormFactors(cts/normMat)) + log(colSums(cts/normMat))

group <- c(sampleTable$condition)

cts$symbol <- row.names(cts)
y <- DGEList(counts=cts[,1:12], group=group, genes = cts$symbol)
cts <- cts[,1:12]

y$offset <- t(t(log(normMat)) + o)
```
y is ready for estimate dispersion functions in edgeR

**note: group value identifies the group memberhip of each sample and should be manually created. group is in y$samples$group.**

**note: the offsets is prioritized over the normalization factors/library sizes when it is available; the offsets will be used and the normalization factors/library sizes will be ignored in most edgeR functions**

### 2. Filtering

low expressed genes are filtered out prior to further analysis:
```R
keep <- rowSums(cpm(y)>1) >= 3
y <- y[keep, , keep.lib.sizes=FALSE]
rm(keep)

# it is recommended to recompute the library sizes:
y$samples$lib.size <- colSums(y$counts)
```

### 3. Normalization (not necessary)
```R
# normalize for RNA composition
# the original library size * the scaling factor = effective library size
y <- calcNormFactors(y)
y$samples
```
**choice of normalized data: https://github.com/hbc/knowledgebase/wiki/Count-normalization-methods**

### 4. Examine data
plotMDS produces a plot in which distances between samples correspond to leading biological coefficient of variation (BCV) between those samples. Ctrl and Exp samples should be separeted by dimensions:
```R
plotMDS(y)
```

Estimating the dispersion:
```R
design <- model.matrix(~group)
y <- estimateDisp(y,design)
y$common.dispersion
# coefficient of variation of biological variation (BCV) is calculated with:
sqrt(y$common.disp)
# The dispersion estimates can be viewed in a BCV plot
plotBCV(y)
```

### 5. Calculate differential expression
```R
# To perform quasi-likelihood F-tests:
fit <- glmQLFit(y,design)
qlf <- glmQLFTest(fit,coef=2)
topTags(qlf)

# Conduct likelihood ratio tests:
lrt <- glmLRT(fit)
topTags(lrt)

# Note that glmLRT has conducted a test for the last coefficient in the linear model:
colnames(design)

plotMD(lrt)
abline(h=c(-1, 1), col="blue")
```
