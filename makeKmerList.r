
AA = c("A" ,"C" ,"D" ,"E" ,"F" ,"G" ,"H", "I" ,"K" ,"L" ,"M" ,"N" ,"P" ,"Q", "R" ,"S" ,"T" ,"V" ,"W" ,"Y")
m = expand.grid(AA,AA,AA,AA,AA)

kmers = paste0(m[,1],m[,2],m[,3],m[,4],m[,5])
ord = order(kmers)
kmers = kmers[ord]
kmers = as.matrix(kmers)
write.csv(kmers,file='Kmer_Dictionary.csv')

