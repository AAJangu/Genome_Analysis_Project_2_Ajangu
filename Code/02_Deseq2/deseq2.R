if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2")

install.packages("ggplot2")
install.packages("Rcpp")
BiocManager::install("SummarizedExperiment")
BiocManager::install("GenomicRanges")
install.packages("RColorBrewer")
install.packages("pheatmap")

library(pheatmap)
library(ggplot2)
library(DESeq2)
library(ggplot2)
library(Rcpp)
library(SummarizedExperiment)
library(GenomicRanges)
library(RColorBrewer)

directory <- "C:/Users/Ajangu/Desktop/Genome Analysis/Genome_Analysis_Project_2/02_htseq"

sampleFiles <- list.files(directory)
sampleCondition<- c("continuous", "continuous", "biomining", "biomining", "continuous")
sampleTable<-data.frame(sampleName=sampleFiles, fileName=sampleFiles, condition=sampleCondition) 
ddsHTSeq<-DESeqDataSetFromHTSeqCount(sampleTable=sampleTable, directory=directory, design=~condition) 
ddsHTSeq

#Pre-filtering
dds<-ddsHTSeq[rowSums(counts(ddsHTSeq))>1,]
dds

#Note on factor levels
dds$condition<-factor(dds$condition,levels=c("continuous","biomining"))
dds$condition<-relevel(dds$condition,ref="continuous")

dds<-DESeq(dds) 
res<-results(dds) 
res

resOrdered<-res[order(res$padj),]
resOrdered

# Filter out NA values
resOrderedFiltered <- resOrdered[complete.cases(resOrdered),]

# View the filtered results
resOrderedFiltered

#SUMMARY
summary(resOrderedFiltered) 


                      #amount of difference between conditions
#with(resOrderedFiltered, plot(log2FoldChange, -log10(padj)))

###################################### colored by significance 

# Define the labels for the x and y axes
xLabel <- "Log2 Fold Change (biomining vs continuous)"
yLabel <- "-Log10 Adjusted p-value"

# Define the color palette for the dots
colorPalette <- c("grey", "red") # Modify the colors as needed

# Plot the log2 fold change vs -log10 adjusted p-value
plot(resOrderedFiltered$log2FoldChange, -log10(resOrderedFiltered$padj),
     xlab = xLabel, ylab = yLabel,
     pch = 16, col = colorPalette[(resOrderedFiltered$padj < 0.05) + 1])

# Add a legend for the colors
legend("topright", legend = c("Not significant", "Significant"),
       col = colorPalette, pch = 16, bty = "n")

################################################ colored by expression

# Define color palette
colorPalette <- colorRampPalette(c("blue", "white", "red"))

# Plot with colored dots
with(resOrderedFiltered, plot(log2FoldChange, -log10(padj), col = colorPalette(100)[as.numeric(cut(log2FoldChange, breaks = 100))], 
                              pch = 16, xlab = "Log2 Fold Change", ylab = "-log10(padj)"))

# Add legend
legend("bottomright", legend = c("Expressed Less", "Expressed More"), pch = 16, col = c("blue", "red"), 
       title = "Expression", cex = 0.8)


#################################### colored based on sign and expr

#GIVE IT VOLCANO PLOT AS A TITLE!!!!!!!

# Define color palette
colorPalette <- colorRampPalette(c("blue", "gray", "red"))

# Plot with colored dots
with(resOrderedFiltered, {
  # Create a logical vector indicating significant genes
  sigGenes <- padj < 0.05
  
  # Plot all genes in gray
  plot(log2FoldChange, -log10(padj), col = "gray", pch = 16, xlab = xLabel, ylab = yLabel)
  
  # Add significant genes with colored dots
  points(log2FoldChange[sigGenes], -log10(padj[sigGenes]), col = colorPalette(100)[as.numeric(cut(log2FoldChange[sigGenes], breaks = 100))], pch = 16)
})

title("Volcano Plot")
# Add legend
legend("bottomright", legend = c("Not Significant", "Downregulated", "Upregulated"), pch = 16, col = c("gray", "blue", "red"), title = "Expression", cex = 0.8)

# Count matrix and heatmap

select <- order(rowMeans(counts(dds,normalized=TRUE)),decreasing=TRUE)[1:20]
nt <- normTransform(dds) # defaults to log2(x+1)
log2.norm.counts <- assay(nt)[select,]
df <- as.data.frame(colData(dds)[c("condition")])

labels <- c("DJFJBFCJ_00418 - Apart of small heat shock protein (HSP20) family",
            "DJFJBFCJ_02475 - UNKNOWN",
            "DJFJBFCJ_00831 - oxidoreductase activity",
            "DJFJBFCJ_01866 - Prevents misfolding and promotes the refolding and proper assembly of unfolded polypeptides generated under stress conditions",
            "DJFJBFCJ_00388 - UNKNOWN",
            "DJFJBFCJ_02098 - Cytochrome C oxidase, cbb3-type, subunit III",
            "DJFJBFCJ_00575 - NHL repeat",
            "DJFJBFCJ_01218 - 'Cold-shock' DNA-binding domain",
            "DJFJBFCJ_01207 - C-terminal, D2-small domain, of ClpB protein",
            "DJFJBFCJ_01781 - Cytochrome C oxidase, mono-heme subunit/FixO",
            "DJFJBFCJ_01177 - Pyruvate:ferredoxin oxidoreductase core domain II",
            "DJFJBFCJ_00203 - Peptidoglycan-binding domain 1 protein",
            "DJFJBFCJ_01382 - UNKNOWN",
            "DJFJBFCJ_00707 - Dihydroprymidine dehydrogenase domain II, 4Fe-4S cluster",
            "DJFJBFCJ_00735 - Histone-like DNA-binding protein which is capable of wrapping DNA to stabilize it",
            "DJFJBFCJ_00219 - B12 binding domain",
            "DJFJBFCJ_00263 - UNKNOWN",
            "DJFJBFCJ_02147 - UNKNOWN",
            "DJFJBFCJ_00110 - UNKNOWN",
            "DJFJBFCJ_02033 - UNKNOWN")

pheatmap(log2.norm.counts, cluster_rows=FALSE, show_rownames=TRUE,
         cluster_cols=TRUE, annotation_col=df, labels_row=labels)


#pca
rld <- rlog(dds)
plotPCA(rld, intgroup=c("condition"))
data <- plotPCA(rld, intgroup=c("condition"), returnData=TRUE)
percentVar <- round(100 * attr(data, "percentVar"))
ggplot(data, aes(PC1, PC2, color = condition)) +
  geom_point(size = 3) +
  xlab(paste0("PC1: ", percentVar[1], "% variance")) +
  ylab(paste0("PC2: ", percentVar[2], "% variance"))


#### End ####
