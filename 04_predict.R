



dt_all_grams <- readRDS("./final/ngram_dataset.RDS")
#ls_all_grams <- readRDS("./final/ngram_dataset_ls.RDS")



dt_all_grams6 <- dt_all_grams[dt_all_grams$'word.count' == 6, ]
dt_all_grams5 <- dt_all_grams[dt_all_grams$'word.count' == 5, ]
dt_all_grams4 <- dt_all_grams[dt_all_grams$'word.count' == 4, ]
dt_all_grams3 <- dt_all_grams[dt_all_grams$'word.count' == 3, ]
dt_all_grams2 <- dt_all_grams[dt_all_grams$'word.count' == 2, ]


predict_word <- function (input) {
     
     input <- tokenize(tail(input, 8))
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


rm(dt_all_grams)
