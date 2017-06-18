

# ######################################################################### #
#                                                                           #
# Utils: WoPr - Word Prediction App                                         #
#   - libraries and functions -                                             #
#                                                                           #
# ######################################################################### # 


library(dplyr)
library(magrittr)
library(stringi)
library(stringr)
library(qdap)
library(assertthat)
library(assertive.types)
library(data.table)
library(shiny)



# LOAD N-GARM DATASET FOR SHINY

# load dataset
dt_all_grams <- readRDS("../app/data/ngram_dataset.RDS")

# split into database chuncks
dt_all_grams6 <- dt_all_grams[dt_all_grams$'word.count' == 6, ]
dt_all_grams5 <- dt_all_grams[dt_all_grams$'word.count' == 5, ]
dt_all_grams4 <- dt_all_grams[dt_all_grams$'word.count' == 4, ]
dt_all_grams3 <- dt_all_grams[dt_all_grams$'word.count' == 3, ]
dt_all_grams2 <- dt_all_grams[dt_all_grams$'word.count' == 2, ]
rm(dt_all_grams)


# TOKENIZE FUNCTION
tokenize <- function(x) {
     
     char <- "[\\.|\\,|\\:|\\/|\\;|\\?|\\!| |\\“|\\”||\\-|\\!|\\(|\\)|\\{|\\}|\\|
     \\%|\\$|\\&|\\*|\\-|\\\\|\\+|\\#|\\^|\\\"|\\<|\\>]{1,10}"
     
     x %<>%
          gsub("c'mon", "come on", ., perl=TRUE) %>%
          gsub("gonna", "going to", ., perl=TRUE) %>%
          gsub("gotta", "got to", ., perl=TRUE) %>%
          gsub("wanna", "want to", ., perl=TRUE) %>%
          gsub("kinda", "kind of", ., perl=TRUE) %>%
          gsub("e-mail", "email", ., perl=TRUE) %>%
          gsub("e-book", "ebook", ., perl=TRUE) %>%
          gsub("N.Y.", "NY", ., perl=TRUE) %>%
          gsub("L.A.", "LA", ., perl=TRUE) %>%
          gsub("D.C.", "DC", ., perl=TRUE) %>%
          gsub(" o ", "oh", ., perl=TRUE) %>%
          gsub("a.m.", "am", ., perl=TRUE) %>%
          gsub("p.m.", "pm", ., perl=TRUE) %>%
          gsub(" u ", " you ", ., perl=TRUE) %>%
          gsub(" r ", " are ", ., perl=TRUE) %>%
          gsub(" cu ", " see you ", ., perl=TRUE) %>%
          gsub("\\’", "'", ., perl=TRUE) %>%
          tolower() 
     x <- unlist( strsplit(x, char, fixed=FALSE, perl=TRUE) ) %>%
          gsub("[^[:print:]]", "", ., perl=TRUE) %>%
          gsub("[^a-z'\\s]", " ", ., perl=TRUE) %>%
          gsub("^'{1}","", ., perl=TRUE) %>%
          gsub("\\s+", " ", ., perl=TRUE) %>%
          trimws()
     
     return(x)
}



# N-GRAM LIST CREATION 
create_ngram <- function (v, n = 2, sep = " ") {
     
     assert_is_character(v, severity = getOption("stop"))
     
     if (length(v) < n) {
          return(c())
     } else {
          starts <- 1:(length(v) - (n - 1))
          ends <- n:length(v)
          Map(function(x, y) {
               paste(v[x:y], collapse=sep)
          }, starts, ends
          )
     }
}

# N-GRAM LIST CREATION, REVERSE
create_ngram_back <- function (v, n = 2, sep = " ") {
     
     assert_is_character(v, severity = getOption("stop"))
     
     if (length(v) < 1) {
          return(c())
     } else {
          paste(
               tail(v, n), collapse=sep
          )
     }
}


# N-GRAM DATA TABLE COMPLETION
clean_ngram_list <- function (x, f = 1) {
     
     # x   list containing n-grams
     # f   n-gram appearance frequency filter 
     
     assert_is_list(x, severity = getOption("stop"))
     
     #convert data 
     x %<>%      
          unlist() %>%
          table() %>%
          as.data.frame(stringsAsFactors = FALSE) 
     
     colnames(x) <- c("ngram", "freq")
     
     #filter 
     x$word.count <- stri_count_words(x[, 1])
     x %<>% 
          filter(word.count == median(x$word.count) &
                      freq >= f)
     
     x <- x[order(-x$freq), ]
     
     if (median(x$word.count) == 1) {
          x$part1 <- ""; x$part2 <- ""
     } else {
          
          y <- matrix(
               unlist(str_split(x[,1], " ")), 
               ncol = median(x$word.count), byrow = TRUE
          ) 
          
          k <- dim(y)[2]
          
          if (k == 2) {
               x <- cbind.data.frame(x, y, stringsAsFactors = FALSE)
          } else {
               x <- cbind.data.frame(x,
                                     apply(y[,1:(k-1)], 1, function (x) {paste(x, collapse=" ")}),
                                     y[,k],
                                     stringsAsFactors = FALSE
               )
          }
          
          colnames(x)[-c(1:3)] <- c(paste0("part", seq(1:2)))
          
     }
     data.table(x)
     
}



# N-GRAM DATA TABLE COMPLETION EXTENDED
clean_ngram_list_full <- function (x, f = 1) {
     
     # x   list containing n-grams
     # f   n-gram appearance frequency filter 
     
     assert_is_list(x, severity = getOption("stop"))
     
     #convert data 
     x %<>%      
          unlist() %>%
          table() %>%
          as.data.frame(stringsAsFactors = FALSE) 
     
     colnames(x) <- c("ngram", "freq")
     
     #filter 
     x$word.count <- stri_count_words(x[, 1])
     x %<>% 
          filter(word.count == median(x$word.count) &
                      freq >= f)
     
     x <- x[order(-x$freq), ]
     
     if (median(x$word.count) == 1) {
          y_full <- cbind(x[,1],
                          matrix(data=NA, ncol=(8-1), nrow = dim(x)[1])
          )
          
          matrix(data = NA, ncol=8)
     } else {
          
          y <- matrix(
               unlist(str_split(x[,1], " ")), 
               ncol = median(x$word.count), byrow = TRUE
          ) 
          
          k <- dim(y)[2]
          
          #assert_all_are_in_closed_range(k, lower = 2, upper = 8, severity = getOption("stop") )
          
          y_full <- cbind(
               y[,1:(k-1)],
               matrix(data=NA, nrow = dim(y)[1], ncol=(8-k)),
               y[,k]
          )
          
          
          x <- cbind.data.frame(x, y_full, stringsAsFactors = FALSE)
          colnames(x)[-c(1:3)] <- c(paste0("part", seq(1:8)))
          
     }
     as.data.table(x)
     
}



# WORD PREDICTION
predict_word <- function (input) {
     
     input <- tokenize(tail(input, 10))
     input <- input[!is.na(match(input, GradyAugmented))]
     
     
     word5 <- create_ngram_back(input, n=5)
     word4 <- create_ngram_back(input, n=4)
     word3 <- create_ngram_back(input, n=3)
     word2 <- create_ngram_back(input, n=2)
     word1 <- create_ngram_back(input, n=1)
     
     matched_6gram <- dt_all_grams6[dt_all_grams6$part1 == word5, part2][1:5]
     matched_5gram <- dt_all_grams5[dt_all_grams5$part1 == word4, part2][1:5]
     matched_4gram <- dt_all_grams4[dt_all_grams4$part1 == word3, part2][1:5]
     matched_3gram <- dt_all_grams3[dt_all_grams3$part1 == word2, part2][1:15]
     matched_2gram <- dt_all_grams2[dt_all_grams2$part1 == word1, part2][1:15]
     
     prediction <- c(
          matched_6gram[!is.na(matched_6gram)],
          matched_5gram[!is.na(matched_5gram)],
          matched_4gram[!is.na(matched_4gram)],
          matched_3gram[!is.na(matched_3gram)],
          matched_2gram[!is.na(matched_2gram)]
     )
     
     prediction <- unique(
          c(
               head(prediction, 3),
               head(prediction[!prediction %in% tm::stopwords()], 8)
          )
     )
     
     if (length(prediction) == 0 ) {
          return(c("I", "a", "the"))
     } else {
          return(prediction)
     }
}




