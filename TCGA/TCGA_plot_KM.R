plot_km <- function(gene, cutoff){
  
  require(TCGAbiolinks)
  require(SummarizedExperiment)
  
  wh = rowData(fpkm_uq)[rowData(fpkm_uq)$external_gene_name %in% gene,]$ensembl_gene_id
  
  if(length(gene)==1){
    
    if(cutoff == 'quantile'){
      top <- quantile(dataFilt[wh,])[3]
      low <- quantile(dataFilt[wh,])[3]
      top.id <- colnames(dataFilt)[dataFilt[wh,]>=top]
      low.id <- colnames(dataFilt)[dataFilt[wh,]<=low]
    }else if(cutoff == 'median'){
      m = median(dataFilt[wh,])
      top.id <- colnames(dataFilt)[dataFilt[wh,]>=m]
      print(length(top.id))
      low.id <- colnames(dataFilt)[dataFilt[wh,]<=m]
      print(length(low.id))
      
      col <- colData(fpkm_uq)
      col$groups <- 'NA'
      col[top.id,]$groups <- paste0(gene,'-high')
      col[low.id,]$groups <- paste0(gene,'-low')
      
    }
    
  }else if(length(gene)==2){
    
    m1 = median(dataFilt[wh[1],])
    m2 = median(dataFilt[wh[2],])
    
    top.id <- colnames(dataFilt)[(dataFilt[wh[1],]>=m1)&(dataFilt[wh[2],]<=m2)]
    low.id <- colnames(dataFilt)[(dataFilt[wh[2],]>=m2)&(dataFilt[wh[1],]<=m1)]
    
    col <- colData(fpkm_uq)
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
