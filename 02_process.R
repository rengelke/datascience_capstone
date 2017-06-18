

# ######################################################################### #
#                                                                           #
# Raw text processing for word prediction algorithm training                #
#   - cleaning, tokenization, formatting -                                  #
#                                                                           #
# ######################################################################### # 



source("utils.R")

data_raw <- readRDS("./final/dataset.RDS")


#tokenize
data_token <- tokenize(data_raw)


     #test
     data_wrds <- unique(bag_o_words(data_token))
     missed_wrds <- data_wrds[is.na(match(data_wrds, GradyAugmented))]
     sort(table(missed_wrds), decreasing=TRUE)
     summary(as.factor(missed_wrds))
     
     #number of words extracted from data set fraction
     length(data_wrds)
     #number of words not found the dictionary
     length(missed_wrds)
     #fraction of words not found in the dictionary
     length(missed_wrds)/length(data_wrds)
     rm(data_wrds, missed_wrds)



#remove words not found in GradyAugmented dictionary
data_token <- data_token[!is.na(match(data_token, GradyAugmented))]
#remove letters except a and i
data_token <- data_token[is.na(match(data_token, tolower(LETTERS[c(-1,-9)]) ))]


#create N-grams
two_grams <- create_ngram(data_token, n=2)
three_grams <- create_ngram(data_token, n=3)
four_grams <- create_ngram(data_token, n=4)
five_grams <- create_ngram(data_token, n=5)
six_grams <- create_ngram(data_token, n=6)


#create N-gram lookup data table
table_two_grams <- clean_ngram_list(two_grams, f=3)
table_three_grams <- clean_ngram_list(three_grams, f=3)
table_four_grams <- clean_ngram_list(four_grams, f=3)
table_five_grams <- clean_ngram_list(five_grams, f=3)
table_six_grams <- clean_ngram_list(six_grams, f=3)



## combine n-gram tables
dt_all_grams  <- as.data.table(
     bind_rows(
          table_two_grams,
          table_three_grams,
          table_four_grams,
          table_five_grams,
          table_six_grams
          )
)


rm(data_raw, data_token)
rm(two_grams, three_grams, four_grams, five_grams, six_grams, seven_grams)
rm(table_two_grams, table_three_grams, table_four_grams, table_five_grams, table_six_grams, table_seven_grams)
gc(verbose=FALSE)

class(dt_all_grams)


#save lookup dataset to the app directory
saveRDS(dt_all_grams, file = "./final/ngram_dataset.RDS")
saveRDS(dt_all_grams, file = "./app/data/ngram_dataset.RDS")






