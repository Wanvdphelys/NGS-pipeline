```R
#data without non-tagetgene 
#read data
gene_summary_1 <- read.table('C:\\Users\\gw-pc\\Desktop\\Human_GeCKOv2_Library_A_3_mageck.csv\\count\\XXQ1\\beta_XXQ1.gene_NON_summary.txt',header = T, stringsAsFactors = F)
gene_summary_2 <- read.table('C:\\Users\\gw-pc\\Desktop\\Human_GeCKOv2_Library_A_3_mageck.csv\\count\\XXQ2\\beta_XXQ2.gene_NON_summary.txt',header = T, stringsAsFactors = F)
gene_summary_3 <- read.table('C:\\Users\\gw-pc\\Desktop\\Human_GeCKOv2_Library_A_3_mageck.csv\\count\\XXQ3\\beta_XXQ3.gene_NON_summary.txt',header = T, stringsAsFactors = F)
#get rank
attach(gene_summary_1)
gene_summary_1 <- gene_summary_1[order(gene_summary_1$NHEJ.beta),]
rownames(gene_summary_1) <- c(1:nrow(gene_summary_1))
gene_summary_1$rank <- row.names(gene_summary_1)
detach(gene_summary_1)
rownames(gene_summary_2) <- c(1:nrow(gene_summary_2))
gene_summary_2$rank <- row.names(gene_summary_2)
rownames(gene_summary_3) <- c(1:nrow(gene_summary_3))
gene_summary_3$rank <- row.names(gene_summary_3)
#NHEJ beta score>0.3
NHEJ_beta_0.3_1 <- gene_summary_1[gene_summary_1$NHEJ.beta > 0.3,]
NHEJ_beta_0.3_2 <- gene_summary_2[gene_summary_2$NHEJ.beta > 0.3,]
NHEJ_beta_0.3_3 <- gene_summary_3[gene_summary_3$NHEJ.beta > 0.3,]
#NHEJ beta score < -0.3
NHEJ_beta_0.3_4 <- gene_summary_1[gene_summary_1$NHEJ.beta < -0.3,]
NHEJ_beta_0.3_5 <- gene_summary_2[gene_summary_2$NHEJ.beta < -0.3,]
NHEJ_beta_0.3_6 <- gene_summary_3[gene_summary_3$NHEJ.beta < -0.3,]
#HR beta score >0.3
HR_beta_0.3_1 <- gene_summary_1[gene_summary_1$HR.beta > 0.3,]
HR_beta_0.3_2 <- gene_summary_2[gene_summary_2$HR.beta > 0.3,]
HR_beta_0.3_3 <- gene_summary_3[gene_summary_3$HR.beta > 0.3,]
#HR beta score < -0.3
HR_beta_0.3_4 <- gene_summary_1[gene_summary_1$HR.beta < -0.3,]
HR_beta_0.3_5 <- gene_summary_2[gene_summary_2$HR.beta < -0.3,]
HR_beta_0.3_6 <- gene_summary_3[gene_summary_3$HR.beta < -0.3,]
# merge
NHEJ_overlap12 <- merge(NHEJ_beta_0.3_1,NHEJ_beta_0.3_2,by = 'Gene')
NHEJ_overlap13 <- merge(NHEJ_beta_0.3_1,NHEJ_beta_0.3_3,by = 'Gene')
NHEJ_overlap23 <- merge(NHEJ_beta_0.3_2,NHEJ_beta_0.3_3,by = 'Gene')
NHEJ_overlap123 <- merge(NHEJ_overlap12,NHEJ_beta_0.3_3,by = 'Gene')
NHEJ_overlap45 <- merge(NHEJ_beta_0.3_4,NHEJ_beta_0.3_5,by = 'Gene')
NHEJ_overlap46 <- merge(NHEJ_beta_0.3_4,NHEJ_beta_0.3_6,by = 'Gene')
NHEJ_overlap56 <- merge(NHEJ_beta_0.3_5,NHEJ_beta_0.3_6,by = 'Gene')
NHEJ_overlap456 <- merge(NHEJ_overlap45,NHEJ_beta_0.3_6,by = 'Gene')
# merge 
HR_overlap12 <- merge(HR_beta_0.3_1,HR_beta_0.3_2,by = 'Gene')
HR_overlap13 <- merge(HR_beta_0.3_1,HR_beta_0.3_3,by = 'Gene')
HR_overlap23 <- merge(HR_beta_0.3_2,HR_beta_0.3_3,by = 'Gene')
HR_overlap123 <- merge(HR_overlap12,HR_beta_0.3_3,by = 'Gene')
HR_overlap45 <- merge(HR_beta_0.3_4,HR_beta_0.3_5,by = 'Gene')
HR_overlap46 <- merge(HR_beta_0.3_4,HR_beta_0.3_6,by = 'Gene')
HR_overlap56 <- merge(HR_beta_0.3_5,HR_beta_0.3_6,by = 'Gene')
HR_overlap456 <- merge(HR_overlap45,HR_beta_0.3_6,by = 'Gene')
HR_NHEJ_0.3 <- merge(HR_overlap123,NHEJ_overlap456,by = 'Gene')
HR_NHEJ <- merge(HR_overlap456,NHEJ_overlap123,by = 'Gene')
#rbind
HR_beta123_0.3 <- merge(HR_overlap12,HR_overlap13,by =  'Gene',all = T)
HR_beta123_0.3 <- merge(HR_beta123_0.3,HR_overlap23,by = 'Gene',all = T)
HR_beta456_0.3 <- merge(HR_overlap45,HR_overlap46,by = 'Gene',all= T)
HR_beta456_0.3 <- merge(HR_beta456_0.3,HR_overlap56,by = 'Gene',all = T)
NHEJ_beta123_0.3 <- merge(NHEJ_overlap12,NHEJ_overlap13,by = 'Gene',all = T)
NHEJ_beta123_0.3 <- merge(NHEJ_beta123_0.3,NHEJ_overlap23,by = 'Gene',all= T)
NHEJ_beta456_0.3 <- merge(NHEJ_overlap45,NHEJ_overlap46,by = 'Gene',all = T)
NHEJ_beta456_0.3 <- merge(NHEJ_beta456_0.3,NHEJ_overlap56,by = 'Gene',all = T)
HR_NHEJ_all_0.3 <- merge(HR_beta123_0.3,NHEJ_beta456_0.3,by = 'Gene')
NHEJ_HR_all_0.3 <- merge(HR_beta456_0.3,NHEJ_beta123_0.3,by = 'Gene')
#venndiagram
#NHEJ beta score >0.3
library(grid)
library(VennDiagram)
draw.triple.venn(area1 = 2166,area2 = 3052,area3 = 1388,n12 = 382,n13 = 200,n23 = 316,n123 = 59, category = c("XXQ1","XXQ2","XXQ3"),fill = c("skyblue","yellow","red"),lwd = rep(2, 3),lty = rep("solid", 3),
col = c("skyblue","yellow","red"),alpha = rep(0.5, 3),print.mode = c('percent','raw'), overrideTriple <- 1, euler.d = T,scaled = T)
#NHEJ beta score < -0.3 
library(grid)
library(VennDiagram)
draw.triple.venn(area1 = 2323,area2 = 2916,area3 = 1504,n12 = 438,n13 = 291,n23 = 308,n123 = 70, category = c("XXQ1","XXQ2","XXQ3"),fill = c("skyblue","yellow","red"),lwd = rep(2, 3),lty = rep("solid", 3),
                 col = c("skyblue","yellow","red"),alpha = rep(0.5, 3),print.mode = c('percent','raw'), overrideTriple <- 1, euler.d = T,scaled = T)
#HR beta score > 0.3
library(grid)
library(VennDiagram)
draw.triple.venn(area1 = 2554,area2 = 2620,area3 = 2542,n12 = 425,n13 = 395,n23 = 401,n123 = 82, category = c("XXQ1","XXQ2","XXQ3"),fill = c("skyblue","yellow","red"),lwd = rep(2, 3),lty = rep("solid", 3),
                 col = c("skyblue","yellow","red"),alpha = rep(0.5, 3),print.mode = c('percent','raw'), overrideTriple <- 1, euler.d = T,scaled = T)
#HR beta score < -0.3
library(grid)
library(VennDiagram)
draw.triple.venn(area1 = 2554,area2 = 2578,area3 = 1556,n12 = 431,n13 = 335,n23 = 357,n123 = 81, category = c("XXQ1","XXQ2","XXQ3"),fill = c("skyblue","yellow","red"),lwd = rep(2, 3),lty = rep("solid", 3),
                 col = c("skyblue","yellow","red"),alpha = rep(0.5, 3),print.mode = c('percent','raw'), overrideTriple <- 1, euler.d = T,scaled = T)
#write NHEJ_overlap123&NEHJ_overlap456 HR_overlap123$HR_overlap456
write.csv(NHEJ_overlap123,'NHEJ_beta_score_0.3.csv')
write.csv(NHEJ_overlap456,'NHEJ_beta_score_-0.3.csv')
write.csv(HR_overlap123,'HR_beta_score_0.3.csv')
write.csv(HR_overlap456,'HR_beta_score_-0.3.csv')
write.csv(HR_overlap12,'HR12_beta_score_0.3.csv')
write.csv(HR_overlap13,'HR13_beta_score_0.3.csv')
write.csv(HR_overlap23,'HR23_beta_score_0.3.csv')
write.csv(HR_overlap45,'HR12_beta_score_-0.3.csv')
write.csv(HR_overlap46,'HR13_beta_score_-0.3.csv')
write.csv(HR_overlap56,'HR23_beta_score_-0.3.csv')
write.csv(NHEJ_overlap12,'NHEJ12_beta_score_0.3.csv')
write.csv(NHEJ_overlap13,'NHEJ13_beta_score_0.3.csv')
write.csv(NHEJ_overlap23,'NHEJ23_beta_score_0.3.csv')
write.csv(NHEJ_overlap45,'NHEJ12_beta_score_-0.3.csv')
write.csv(NHEJ_overlap46,'NHEJ13_beta_score_-0.3.csv')
write.csv(NHEJ_overlap56,'NHEJ23_beta_score_-0.3.csv')
write.csv(gene_summary_1,'beta_XXQ1-gene_summary.csv')
write.csv(HR_NHEJ_all_0.3,'HR_NHEJ_all_beta_0.3.csv')
write.csv(NHEJ_HR_all_0.3,'NHEJ_HR_all_beta_0.3.csv')
write.csv(HR_beta123_0.3,'HR_beta123_0.3.csv')
write.csv(HR_beta456_0.3,'HR_beta123_-0.3.csv')
write.csv(NHEJ_beta123_0.3,'NHEJ_beta123_0.3.csv')
write.csv(NHEJ_beta456_0.3,'NHEJ_beta123_-0.3.csv')

#ggplot2
library(ggplot2)
attach(gene_summary_1)
gene_summary_1 <- gene_summary_1[order(gene_summary_1$NHEJ.beta),]
rownames(gene_summary_1) <- c(1:nrow(gene_summary_1))
gene_summary_1$rank <- row.names(gene_summary_1)
p<- ggplot(data = gene_summary_1,aes(x = gene_summary_1$rank,y = gene_summary_1$NHEJ.beta))
p+geom_point()
plot(gene_summary_1$rank,gene_summary_1$NHEJ.beta)
detach(gene_summary_1)
```
