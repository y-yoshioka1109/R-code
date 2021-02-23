library(ggplot2)

df <- read.delim("hit3.txt",header=T)
g <- ggplot(df, aes(x = Class, y = Value, fill = Name))
g <- g + geom_bar(stat = "identity")
#g <- g + theme(legend.position = 'none')#判例に表示される数が多くなる場合は削除する
#g <- g + theme(axis.text.x = element_text(angle = 30, hjust = 1)) #x軸のラベルを斜めにする
g
