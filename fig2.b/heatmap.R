library(pheatmap) 
library(ggplot2)


df = read.delim("data.heatmap.txt",
                header = T,           
                sep = "\t",              
                row.names = 1,           
                fill=T)                  

dfSample = read.delim("sample.class.txt",header = T,row.names = 1,fill = T,sep = "\t")


p = pheatmap(df, 
         annotation_col=dfSample,
         show_colnames = TRUE,     
         show_rownames=F,       # By default, row names are not displayed
         fontsize=7,               
         color = colorRampPalette(c('#0000ff','#ffffff','#ff0000'))(50), 
         annotation_legend=TRUE,   
         border_color=NA,          
         scale="row",              
         cluster_rows = TRUE,      
         cluster_cols = TRUE       
)
p

ggsave(filename = "result_heatamp.pdf",plot=p,width=6,height = 7)


