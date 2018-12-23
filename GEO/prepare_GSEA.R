## prepare required files for GSEA analysis

prep_gsea <- function(gene, cutoff, expr){
  
  require(tidyverse)
  require(SummarizedExperiment)
  
  if(cutoff == 'quantile'){
    
    top <- quantile(expr[gene,])[4]
    low <- quantile(expr[gene,])[2]
    top.data <- expr[,expr[gene,]>top]
    low.data <- expr[,expr[gene,]<=low]
    
    gsea.data <- data.frame(NAME = rownames(top.data), DESCRIPTION = 'na')
    gsea.data <- cbind(gsea.data, top.data)
    gsea.data <- cbind(gsea.data, low.data)
    
    write_tsv(gsea.data, paste0(gene,"_hi_vs_lo_quartile_dataset.txt"))
    
    # write classification file
    top.len <- ncol(top.data)
    low.len <- ncol(low.data)
    sum.len <- top.len+low.len
    
    fileConn<-file(paste0(gene,"_hi_vs_lo_quartile_cluster.cls"))
    l1 <- paste0(sum.len, ' 2 1')
    l2 <- paste0('# ',gene,'-high ',gene,'-low')
    
    l3.top <- paste0(rep(paste0(gene,'-high'), top.len), collapse = ' ')
    l3.low <- paste0(rep(paste0(gene,'-low'), low.len), collapse = ' ')
    l3 <- paste0(l3.top,' ',l3.low)
    
    writeLines(c(l1,l2,l3), fileConn)
    close(fileConn)
    
  }else if(cutoff == 'median'){
    
    m = median(as.numeric(expr[gene,]))
    top.data <- expr[,expr[gene,]>m]
    low.data <- expr[,expr[gene,]<=m]
    
    gsea.data <- data.frame(NAME = rownames(top.data), DESCRIPTION = 'na')
    gsea.data <- cbind(gsea.data, top.data)
    gsea.data <- cbind(gsea.data, low.data)
    
    write_tsv(gsea.data, paste0(gene,"_hi_vs_lo_median_dataset.txt"))
    
    
    # write classification file
    top.len <- ncol(top.data)
    low.len <- ncol(low.data)
    sum.len <- top.len+low.len
    
    fileConn<-file(paste0(gene,"_hi_vs_lo_median_cluster.cls"))
    l1 <- paste0(sum.len, ' 2 1')
    l2 <- paste0('# ',gene,'-high ',gene,'-low')
    
    l3.top <- paste0(rep(paste0(gene,'-high'), top.len), collapse = ' ')
    l3.low <- paste0(rep(paste0(gene,'-low'), low.len), collapse = ' ')
    l3 <- paste0(l3.top,' ',l3.low)
    
    writeLines(c(l1,l2,l3), fileConn)
    close(fileConn)
  }
  
}
