prep_gsea <- function(gene, cutoff, se, expr){
  
  require(TCGAbiolinks)
  require(SummarizedExperiment)
  
  wh = rowData(se)[rowData(se)$external_gene_name == gene,]$ensembl_gene_id
  gene_map <- rowData(se)$external_gene_name
  names(gene_map) <- rowData(se)$ensembl_gene_id
  
  if(cutoff == 'quantile'){
    
    top <- quantile(expr[wh,])[4]
    low <- quantile(expr[wh,])[2]
    top.data <- expr[,expr[wh,]>top]
    low.data <- expr[,expr[wh,]<=low]
    
    gsea.data <- data.frame(NAME = gene_map[rownames(top.data)], DESCRIPTION = 'na')
    gsea.data <- cbind(gsea.data, top.data)
    gsea.data <- cbind(gsea.data, low.data)
    
    write_tsv(gsea.data, paste0(gene,"_hi_vs_lo_quartile_dataset.txt"))
    
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
    
    m = median(expr[wh,])
    top.data <- expr[,expr[wh,]>m]
    low.data <- expr[,expr[wh,]<=m]
    
    gsea.data <- data.frame(NAME = gene_map[rownames(top.data)], DESCRIPTION = 'na')
    gsea.data <- cbind(gsea.data, top.data)
    gsea.data <- cbind(gsea.data, low.data)
    
    write_tsv(gsea.data, paste0(gene,"_hi_vs_lo_median_dataset.txt"))
    
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
