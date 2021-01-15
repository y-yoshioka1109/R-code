library(UpSetR)

#データ読み込み1
D1 <- read.delim("Lst1.txt",header=T,check.names=F)
D12 <- D1[,1]

#データ読み込み2
D2 <- read.delim("Lst2",header=T,check.names=F)
D22 <- D2[,1]

#データ読み込み3
D3 <- read.delim("Lst3",header=T,check.names=F)
D32 <- D3[,1]

##データ読み込み4
D4 <- read.delim("Lst4",header=T,check.names=F)
D42 <- D4[,1]

data <- list(A = D12, B = D22, C = D32, D = D42)
upset(fromList(data), order.by = "freq")
