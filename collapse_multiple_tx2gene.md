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
