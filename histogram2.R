library("ggplot2")
df <- read.delim("hist2.txt", header=T)
g <- NULL
g <- ggplot(df, aes(x = Value, fill=Class))
g <- g + geom_histogram(bins = 100,alpha=0.6,position="identity")
g

#折れ線で表す場合はこっち
g <- NULL
g <- ggplot(df, aes(x = Value, colour=Class))
g <- g + geom_freqpoly(binwidth=2)
g
