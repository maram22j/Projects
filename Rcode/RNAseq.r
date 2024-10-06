#downloading library:
library(ggplot2)
library(dplyr)
#downloading dataset:
file<-"https://gist.githubusercontent.com/stephenturner/806e31fce55a8b7175af/raw/1a507c4c3f9f1baaa3a69187223ff3d3050628d4/results.txt"
RNAseq<-read.table(file,header = TRUE)
#add a new coloum called Gene expression that contains "NO":
RNAseq$geneexpression<-"NO"
#differentiate between up and down regulated genes by replacing "NO" in the gene expression coloum with the appropriate 
RNAseq$geneexpression[RNAseq$log2FoldChange>1 & RNAseq$pvalue<0.01]<-"UP"
RNAseq$geneexpression[RNAseq$log2FoldChange<(-1) & RNAseq$pvalue<0.01]<-"DOWN"
table(RNAseq$geneexpression)
#volcano plot implementation:
ggplot(data=RNAseq,aes(x=log2FoldChange,y=-log10(pvalue),col=geneexpression),label = delabel)+geom_point(size=2)+ggtitle("Volcano plot")+
scale_color_manual(values = c("#00AFBB", "grey", "#FFDB6D"), # to set the colours of our variable
                   labels = c("Downregulated", "Not significant", "Upregulated"))+coord_cartesian(ylim = c(0, 10), xlim = c(-2, 2))
write.csv(RNAseq[RNAseq$geneexpression=="UP",],file = "upregulated.csv",row.names = T)
write.csv(RNAseq[RNAseq$geneexpression=="DOWN",],file = "upregulated.csv",row.names = T)
#selecting top 5 upregulated genes:
setwd("C:/Users/maram/OneDrive/Documents/Hackbio")
upregulated<-read.csv(file = "upregulated.csv",header = TRUE)
upregulated$X<-NULL
print(upregulated)
topregulated<-upregulated[1:5,]
print(topregulated)
#selecting top 5 downregulated genes:
downregulated<-read.csv(file="downregulated.csv",header = TRUE)
downregulated$X<-NULL
print(downregulated)
topdown<-downregulated[1:5,]
print(topdown)
