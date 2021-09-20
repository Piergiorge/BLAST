#parser blast
library(ggplot2)
library(dplyr)
library(plotly)

results_blast <- read.table("...", sep = "\t", header = T)
results_blast_filter <- results_blast[results_blast$score > 120 & results_blast$evalue < 10^-3 & results_blast$qseqid != results_blast$sseqid, ]
results_blast_filter <- results_blast_filter[order(results_blast_filter$evalue, decreasing = F),]
dim (results_blast_filter)
maiores <- (head(results_blast_filter,10))
summary(maiores)
ggplot (data = results_blast_filter) + geom_point(aes(score, pident, color = pident)) + theme_minimal()

results_blast_filter2 <- results_blast_filter[((results_blast_filter$qend - results_blast_filter$qstart + 1)/(results_blast_filter$send - results_blast_filter$sstart + 1)) * 100 > 75 & results_blast_filter$pident > 35, ]

dim (results_blast_filter2)
results_blast_filter2[order(results_blast_filter2$evalue, decreasing = F),]
#coverage
ggplot (data = results_blast_filter2) + geom_point(aes(score, pident, color = pident)) + theme_minimal()

by_score <- results_blast_filter2 %>% group_by(c(score))

x <- by_score %>% summarise(quantile_score = quantile (score))
ggplot (data = x) + geom_boxplot(aes('Score', quantile_score)) +
  theme_minimal() + xlab('OutPut') +
  ylab('Quantile') + ggtitle('Score - Quantile', subtitle = waiver())
