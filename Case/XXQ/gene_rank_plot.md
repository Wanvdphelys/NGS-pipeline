plot gene rank with ggplot2
========

The gene beta score (calculated by MeGeck) was plotted against gene essentiality rank

```R
library(ggplot2)

NHEJ_reg <- Candidate_list$`Regulator for NHEJ`[2:nrow(Candidate_list)]
beta_XXQall_gene_summary$NHEJ_reg <- 0
beta_XXQall_gene_summary$NHEJ_reg[beta_XXQall_gene_summary$Gene %in% NHEJ_reg] <- 1

NHEJ_list <- positive_regulator_for_NHEJ_negative_for_HR$X5[3:nrow(positive_regulator_for_NHEJ_negative_for_HR)]
beta_XXQall_gene_summary$NHEJ_can <- 0
beta_XXQall_gene_summary$NHEJ_can[beta_XXQall_gene_summary$Gene %in% NHEJ_list] <- 1

ggplot(beta_XXQall_gene_summary, aes(x = NHEJ.rank, y = NHEJ.beta)) +
  geom_point(aes(colour = factor(NHEJ_reg), size = factor(NHEJ_reg))) + 
  scale_color_manual(values=c("grey", "red")) +
  scale_size_discrete(range = c(1,1.5))

p <- ggplot(beta_XXQall_gene_summary[beta_XXQall_gene_summary$NHEJ_reg == 0,],
       aes(x = NHEJ.rank, y = NHEJ.beta)) + 
  geom_point(colour = 'grey', size = 1)
p

p1 <- p + geom_point(data = beta_XXQall_gene_summary[beta_XXQall_gene_summary$NHEJ_reg == 1,],
             mapping = aes(x = NHEJ.rank, y = NHEJ.beta), colour = 'red', size = 1)

x1 <- beta_XXQall_gene_summary$NHEJ.rank[beta_XXQall_gene_summary$NHEJ_reg == 1]-5
x2 <- x1 + 10
p1 <- p1 + annotate("rect", xmin = x1, xmax = x2, ymin = -2, ymax = -1.8)
p1

ggplot(data = beta_XXQall_gene_summary, aes(x = NHEJ.rank, y = NHEJ.beta)) +
  geom_point(colour = 'grey', size = 1) +
  geom_vline(xintercept = c(120,662), size = 1)

p2 <- p+ geom_point(data = beta_XXQall_gene_summary[beta_XXQall_gene_summary$NHEJ_can == 1,],
                    mapping = aes(x = NHEJ.rank, y = NHEJ.beta), colour = 'red', size = 1)
p2 <- p2 + geom_hline(yintercept = c(-0.32,0.26))
p2


HR_reg <- Candidate_list$`positive regulator for HR`[2:nrow(Candidate_list)]
beta_XXQall_gene_summary$HR_reg <- 0
beta_XXQall_gene_summary$HR_reg[beta_XXQall_gene_summary$Gene %in% HR_reg] <- 1

ggplot(beta_XXQall_gene_summary, aes(x = HR.rank, y = HR.beta)) +
  geom_point(aes(colour = factor(HR_reg), size = factor(HR_reg))) + 
  scale_color_manual(values=c("grey", "red")) +
  scale_size_discrete(range = c(1,1.5))

p <- ggplot(beta_XXQall_gene_summary[beta_XXQall_gene_summary$HR_reg == 0,],
            aes(x = HR.rank, y = HR.beta)) + 
  geom_point(colour = 'grey', size = 1)
p

p <- p + geom_point(data = beta_XXQall_gene_summary[beta_XXQall_gene_summary$HR_reg == 1,],
                    mapping = aes(x = HR.rank, y = HR.beta), colour = 'red', size = 1)
p <- p + geom_hline(yintercept = c(-0.32,0.26))
p


ggplot(beta_XXQall_gene_summary, aes(x = NHEJ.beta))+
  geom_histogram(binwidth = 0.01,fill="white",colour="red



```
