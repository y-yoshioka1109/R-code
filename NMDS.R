##http://jsnfri.fra.affrc.go.jp/gunshu/2nmds.html

library(reshape2)
library(genefilter)
library(ggfortify)
library(dplyr)
library(tidyr)
library(ggrepel)
library(factoextra)
library(edgeR)
library(vegan)
library(ggforce)
#version確認
#packageVersion("")


data <- read.delim("test_NMDS.txt",header=T,check.names=F,row.names=1) #データの読み込み
dim(data) #行列数を確認

#低カウント遺伝子を除去する(一般的に10カウント以下はノイズとして扱われている)
param1 <-16 #サンプル数を指定(列数)
param2 <- 5 #低発現を5に設定
f1 <- kOverA(param1, A=param2) #関数を定義
ffun <- filterfun(f1) #関数を作成
obj <- genefilter(data,ffun) #条件を満たすか判定。満たすとTRUEにする
data4 <- data[obj,] #TRUEの要素のみ抽出した結果を保存
dim(data4) #行列数を確認。データを入れた時と行数が変わっていることを確認

#列名を有効にするために一旦保存して、再読み込み
write.table(data4,"tmp.txt",sep="\t",row.names=T,quote=FALSE)
#ファイルを読み込む前にgeneIDを1列目の列名に追記する
data5 <- read.table("tmp.txt",header=T,check.names=F,row.names=1)
head(data5)
dim(data5)

#nMDS
data6 <- t(data5)
res1.mds <- metaMDS(data6, distance="horn", autotransform = FALSE, trace = 0)
data.scores <- as.data.frame(scores(res1.mds))
data.scores$sample_id <- rownames(data.scores)

group <- c('A','B','C','D','A','B','C','D','A','B','C','D','A','B','C','D')

D4 <- cbind(data.scores,group)

g <- NULL
g <- ggplot(data=D4, aes(x=NMDS1, y=NMDS2, colour=group)) 
g <- g + geom_mark_ellipse(aes(color=group))
g <- g + geom_point(size=6,aes(shape=group))
g
