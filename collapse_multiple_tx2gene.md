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
 method from: 
 ***Strategies for aggregating gene expression data: The collapseRows R function***
 https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-12-322
 
 ariticles that used this methods: <\br>
 Science  01 Dec 2017 http://science.sciencemag.org/content/358/6367/eaal5081.full
 
 Nature Communications 09 December 2015 https://www.nature.com/articles/ncomms9885
 
 Nature Neuroscience 22 February 2016 https://www.nature.com/articles/nn.4256
 
 Nature 25 May 2014 https://www.nature.com/articles/nature13255
 
 Nature Neuroscience 16 November 2015 https://www.nature.com/articles/nn.4171
 
 Bioinformatics 15 June 2014 https://academic.oup.com/bioinformatics/article/30/12/i105/388164
 
