```R
library(WGCNA)

collapseRows(datET, # gene expression matrix
             rowGroup, # gene symbol
             rowID, # tx name
             method="MaxMean", 
             connectivityBasedCollapsing=FALSE,
             methodFunction=NULL, connectivityPower=1,
             selectFewestMissing=TRUE, thresholdCombine=NA)
             

 ```
 https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-12-322
