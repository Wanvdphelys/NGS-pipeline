plot_km <- function(gene, cutoff, se, expr){
  
  require(TCGAbiolinks)
  require(SummarizedExperiment)
  
  wh = rowData(se)[rowData(se)$external_gene_name %in% gene,]$ensembl_gene_id
  
  if(length(gene)==1){
    
    if(cutoff == 'quantile'){
      top <- quantile(expr[wh,])[3]
      low <- quantile(expr[wh,])[3]
      top.id <- colnames(expr)[expr[wh,]>=top]
      low.id <- colnames(expr)[expr[wh,]<=low]
    }else if(cutoff == 'median'){
      m = median(expr[wh,])
      top.id <- colnames(expr)[expr[wh,]>=m]
      print(length(top.id))
      low.id <- colnames(expr)[expr[wh,]<=m]
      print(length(low.id))
      
      col <- colData(se)
      col$groups <- 'NA'
      col[top.id,]$groups <- paste0(gene,'-high')
      col[low.id,]$groups <- paste0(gene,'-low')
      
    }
    
  }else if(length(gene)==2){
    
    m1 = median(expr[wh[1],])
    m2 = median(expr[wh[2],])
    
    top.id <- colnames(expr)[(expr[wh[1],]>=m1)&(expr[wh[2],]<=m2)]
    low.id <- colnames(expr)[(expr[wh[2],]>=m2)&(expr[wh[1],]<=m1)]
    
    col <- colData(se)
    col$groups <- 'NA'
    col[top.id,]$groups <- paste0(gene[1],'-high  ',gene[2],'-low')
    col[low.id,]$groups <- paste0(gene[1],'-low  ',gene[2],'-high')
    
  }
  
  TCGAanalyze_survival(data = col[!col$groups=='NA',],
                       clusterCol = "groups",
                       main = "TCGA kaplan meier survival plot from consensus cluster",
                       legend = "RNA Group",height = 10,
                       risk.table = T,conf.int = F,
                       color = c("red","black"),
                       filename = "survival_lgg_expression_subtypes.png")
  
}
