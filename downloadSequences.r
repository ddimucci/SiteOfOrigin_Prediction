# 17 June 20202
# Demetrius DiMucci

x <- read.csv('SEQID_info.csv',header=TRUE)

files <- x[,1]

bad <- which(is.na(files))

if(length(bad) > 0){
        files = files[-bad]
}

for(i in 1:length(files)){
        path <- paste0('http://www.homd.org/ftp/genomes/PROKKA/current/faa/',files[i],'.faa')
        call = paste('wget',path)
        system(call)
}

