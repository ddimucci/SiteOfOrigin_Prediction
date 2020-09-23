############################# GetKmerVector.r
#22 Aug 2020
args = commandArgs(trailingOnly=TRUE)

begin = args[1]
finish = args[2]



seq = list.files('KMER_COUNTS/',full.name=T)[begin:finish]

targetFiles = list.files('KMER_VECTORS/',full.name=T)

x = read.csv('Kmer_Dictionary.csv')

for(i in 1:length(seq)){

        bug = gsub('\\.csv','',seq[i])
        bug = gsub('COUNTS','VECTORS',bug)
        filename = paste0(bug,'_Vector.csv')
        if(filename %in% targetFiles){
                print(filename)
        } else {
                y = read.csv(seq[i])
                h = unique(y[,c(5,8)])
                bad = grep('X',h[,1])
                if(length(bad) > 0){
                        h = h[-bad,]
                }

                h2 = as.vector(h[,1])
                dex = which(x[,2] %in% h2)
                vec = rep(0,nrow(x))
                vec[dex] = h[,2]
#               #cumulative = cumulative + vec

                bug = gsub('\\.csv','',seq[i])
                bug = gsub('COUNTS','VECTORS',bug)
                filename = paste0(bug,'_Vector.csv')
                write.csv(vec,file=filename)

        }

}
filename = paste0('cumulative',begin,'.csv')
write.csv(cumulative,file=filename)
