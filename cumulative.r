vecs = list.files('KMER_VECTORS/',full.names=T)

x = read.csv(vecs[1])
x = x[,2]
cumulative = x
prevalence = sign(cumulative)

for(i in 1:length(vecs)){
        #print(i)
        x = read.csv(vecs[i])
        x = x[,2]
        if(length(x) != length(cumulative)){
                print(i)
        }
        cumulative = cumulative + x
        prevalence = prevalence + sign(x)
}
write.csv(cumulative,file='Cumulative_KmerCounts.csv')
write.csv(prevalence,file='Prevalence_Kmers.csv')
