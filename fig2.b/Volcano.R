library(ggplot2)
library(ggrepel)  

data = read.delim("Volcano.txt",header = T)

FC = 1.5 
PValue = 0.05 


data$sig[(-1*log10(data$PValue) < -1*log10(PValue)|data$PValue=="NA")|(log2(data$FC) < log2(FC))& log2(data$FC) > -log2(FC)] <- "NotSig"
data$sig[-1*log10(data$PValue) >= -1*log10(PValue) & log2(data$FC) >= log2(FC)] <- "Up"
data$sig[-1*log10(data$PValue) >= -1*log10(PValue) & log2(data$FC) <= -log2(FC)] <- "Down"

# Marking method (1)
# According to the Marker column in the data frame, those with 1 are labeled and those with 0 are not labeled
data$label=ifelse(data$Marker == 1, as.character(data$Name), '')
# (OR) Marking method (2)
# Appropriate points were selected according to how much PValue was less than and how much the absolute value of log[2]FC was greater than

# PvalueLimit = 0.0001
# FCLimit = 5
# data$label=ifelse(data$PValue < PvalueLimit & abs(log2(data$FC)) >= FCLimit, as.character(data$Name), '')

# 绘图
ggplot(data,aes(log2(data$FC),-1*log10(data$PValue))) +   
  geom_point(aes(color = sig)) +                          
  labs(title="volcanoplot",                                
       x="log[2](FC)", 
       y="-log[10](PValue)") + 
  geom_hline(yintercept=-log10(PValue),linetype=2)+       
  geom_vline(xintercept=c(-log2(FC),log2(FC)),linetype=2)+ 
  geom_text_repel(aes(x = log2(data$FC),                   
                      y = -1*log10(data$PValue),          
                      label=label),                       
                  max.overlaps = 10000,                    
                  size=3,                                  
                  box.padding=unit(0.5,'lines'),           
                  point.padding=unit(0.1, 'lines'), 
                  segment.color='black',                   
                  show.legend=FALSE)+
  theme_bw()

ggsave("result_volcano.pdf",width = 6,height = 6)
