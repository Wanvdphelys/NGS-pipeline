## Combine multiple platforms in GSE16432

### 1. combine platforms on gene level using affyPLM and WGCNA packages
GSE16432 is consisted of 9 different platforms. Also this dataset does not supply original .CEL file, so I can't use RMA or related softwares which basically all require .CEL file. 

Luckily I have found a workaround. The **normalize.ExpressionSet.quantiles** function from **affyPLM** package can normalize single platform data on the expressionset level. This function has multiple variations, but most of them raise an error. Only  normalize.ExpressionSet.quantiles functions smoothly. Although this function performs single platform normalization, by raw eyes check the batch effects between different platform is mild. Thus the datas are suitable for cross-platform calculation.

Because different platforms have diferent numbers of probes or even different probe names, it is impossible to merge platforms on probe level. So I used **collapseRows** function from **WGCNA** package to summarize probes to genes and then merge platforms on gene level.


```R
multiCombineES <- function(eslist){
  
  require(affyPLM)
  require(WGCNA)
  
  pd.all <- tibble()
  expr.all <- tibble()
  l <- length(eslist)
  init <- TRUE
  
  for(i in seq_along(eslist)){
    
    pd <- eslist[[i]]@phenoData@data
    
    # here comes the function
    expr <- normalize.ExpressionSet.quantiles(eslist[[i]])
    fd <- expr@featureData@data
    expr <- expr@assayData$exprs
    expr <- as.data.frame(expr)
    
    if("Gene Symbol" %in% colnames(fd)){gname <- "Gene Symbol"}else{gname <- "CompositeSequence BioSequence Database Entry [Gene Symbol]"}
    
    # summarize to gene level
    expr <- collapseRows(expr, # gene expression matrix
                           rowGroup = fd[,gname], # gene symbol
                           rowID = fd$ID, # tx name
                           method="MaxMean", # default 
                           connectivityBasedCollapsing=FALSE,
                           methodFunction=NULL, connectivityPower=1,
                           selectFewestMissing=TRUE, thresholdCombine=NA)
    expr <- as.data.frame(expr$datETcollapsed)
    
    pd.all <- bind_rows(pd.all, pd)
    
    if(init){
      expr.all <- expr
    }else{
      expr.all <- merge(expr.all, expr, by=0)
      rownames(expr.all) <- expr.all$Row.names
      expr.all <- expr.all[,-1]
    }
    
    init <- FALSE
  
    print(paste0("[",paste0(rep("-",30*i/l), collapse = ""), i, "/", l,
                 paste0(rep(" ",30-(30*i/l)), collapse = ""),
                 "]", collapse = ""
                 )
          )
    
  }
  
  return(list(PhenoData = pd.all, NormalizedExpressionData = expr.all))
}

```

### 2. plot gene expression level to inspect batch effects

```R
plot_ave_profile <- function(ex){
  require(ggplot2)
  require(tidyverse)
  
  ex <- gather(ex)
  
  ggplot(ex) + geom_boxplot(aes(0,value, group = key))
}
```
