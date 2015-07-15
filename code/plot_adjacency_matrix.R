setwd("~/matlab")
rm(list=ls())
adjmatrix <- as.matrix(read.csv(file="BN_handprint4.csv",head=FALSE,sep=","))
mode(adjmatrix) <- "numeric"
library(igraph)
g1 <- graph.adjacency(adjmatrix, mode="undirected")
tkplot(g1)