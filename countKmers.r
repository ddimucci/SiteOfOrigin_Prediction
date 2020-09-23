#12 June 2020
# Demetrius DiMucci

# This code will generate a table of Kmers for a given fasta file for each ORF

# Initialize the directory where the table will be deposited

path <- 'YOUR TARGET DIRECTORY HERE'


# Accept line arguments and acknowledge the fasta file
args = commandArgs(trailingOnly=TRUE)
fasta = args[1]

### Load Packages
library(tcR)
library(Biostrings)

# Read the fasta file
x <- readBStringSet(fasta)

# get the ORF ids and cut off the functional annotation
SEQids <- names(x)

# for(i in 1:length(SEQids)){
#   SEQids[i] <- gsub(' .*','',SEQids[i])
# }
# Split the ORF names into sequence names and predicted function
SEQids <- gsub(' .*','',SEQids)
genomeID <- gsub('_.*','',SEQids[1])
annotations <- gsub('^(.{14}).','',names(x))

###### Start counting the kmers in each ORF
all <- list()
allmers <- vector()
ID <- vector()

for(i in 1:length(x)){
  temp <- get.kmers(as.character(x[[i]]),.k=5)
  temp = cbind(SEQids[i],temp)
  colnames(temp)[1] = 'Sequence_ID'
  all[[i]] <- cbind(temp,annotations[i])
}


# Organize the counts into a big table
bigTab <- vector()
for(i in 1:length(all)){
  bigTab <- rbind(bigTab,all[[i]])
  #print(i)
}
bigTab <- cbind(genomeID,bigTab)
colnames(bigTab)[ncol(bigTab)]='Annotation'


# commas cause problems when splitting the table - use gsub to replace them with dashes
bigTab$Annotation = gsub('\\,','-',bigTab$Annotation)



#  For each kmer also calculate how many times it appeared genome-wide
kmers <- unique(bigTab$Kmers)
mers <- table(bigTab$Kmers)
singletons = which(mers == 1)
indices = seq(length(mers))
multiples = indices[-singletons] # means kmers that appeared in multiple ORFS
length(multiples)
mult = names(mers[multiples])
counts <- vector()
genomeCount <- bigTab$Count
for(i in 1:length(mult)){
  hits = which(bigTab$Kmers == mult[i])
  counts[i] <- sum(bigTab$Count[hits])
  genomeCount[hits] <- counts[i]
  if(i %% 100 == 0){
    print(i)
  }
}
bigTab <- cbind(bigTab,genomeCount)


# Save the table to the kmer_database
filename <- paste0(path,genomeID,'.csv')
write.csv(bigTab, file = filename,sep='\t')
print('Work Complete')
