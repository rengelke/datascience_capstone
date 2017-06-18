



# download and extract raw text data 

destination_file <- "Coursera-SwiftKey.zip"
source_file <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
download.file(source_file, destination_file)
unzip(destination_file)

dir("./final")
dir("./final/en_US")


# combine english/US files to create dataset

blogs <- readLines("final/en_US/en_US.blogs.txt", encoding="UTF-8")
twitter <- readLines("final/en_US/en_US.twitter.txt", encoding="UTF-8")
news <- readLines("final/en_US/en_US.news.txt", encoding="UTF-8")

#sample a fraction of N lines for analysis
set.seed(1607)
n = 0.05  # percent fraction
blogs <- blogs[sample(1:length(blogs), length(blogs)*n, replace=FALSE)]
twitter <- twitter[sample(1:length(twitter), length(twitter)*n, replace=FALSE)]
news <- news[sample(1:length(news), length(news)*n, replace=FALSE)]

dataset <- c(blogs, twitter, news)


saveRDS(dataset, file = "./final/dataset.RDS")
rm(blogs, news, twitter, dataset, n); gc(verbose=FALSE)

