data_preprep <- function(data,prefix){
  
  dataPrep <- TCGAanalyze_Preprocessing(object = data, cor.cut = 0.6)
  
  dataNorm <- TCGAanalyze_Normalization(tabDF = dataPrep,
                                        geneInfo = TCGAbiolinks::geneInfoHT,
                                        method = 'gcContent')         
  
  return(TCGAanalyze_Filtering(tabDF = dataNorm,
                               method = "quantile", 
                               qnt.cut =  0.25))
}
