

dt_all_grams <- readRDS("./final/ngram_dataset.RDS")
ls_all_grams <- readRDS("./final/ngram_dataset_ls.RDS")


input <- c("hello, how are you")
input <- c("do you want")
input <- "to see the movie this"
input <- "anything to see this"

input <- "When you breathe, I want to be the air for you. I'll be there for you, I'd live and I'd"; "die"
#for, if, to // like, be, love
input <- "Guy at my table's wife got up to go to the bathroom and I asked about dessert and he started telling me about his"
#life, work, job // new, work, own
input <- "I'd give anything to see arctic monkeys this"; "weekend"

input <- "Talking to your mom has the same effect as a hug and helps reduce your"; "stress"
input <- "When you were in Holland you were like 1 inch away from me but you hadn't time to take a"
input <- "I'd just like all of these questions answered, a presentation of evidence, and a jury to settle the"; "case"
input <- "I can't deal with unsymetrical things. I can't even hold an uneven number of bags of groceries in each"; "hand"
input <- "Every inch of you is perfect from the bottom to the"; "top"
input <- "I’m thankful my childhood was filled with imagination and bruises from playing"; "outside"
input <- "I like how the same people are in almost all of Adam Sandler's"; "movies"





# Stupid Backoff ----------------------------------------------------------


input <- tokenize(input)
input <- input[!is.na(match(input, GradyAugmented))]


word_intersect <- intersect(ls_all_grams, input)
input <- tokenize(intersect(input, word_intersect))



word6 <- create_ngram_back(tokenize(input), n=6)
word5 <- create_ngram_back(tokenize(input), n=5)
word4 <- create_ngram_back(tokenize(input), n=4)
word3 <- create_ngram_back(tokenize(input), n=3)
word2 <- create_ngram_back(tokenize(input), n=2)
word1 <- create_ngram_back(tokenize(input), n=1)


matched_7gram <- dt_all_grams[dt_all_grams$part1 == word6, ]
matched_7gram
matched_6gram <- dt_all_grams[dt_all_grams$part1 == word5, ]
matched_6gram
matched_5gram <- dt_all_grams[dt_all_grams$part1 == word4, ]
matched_5gram
matched_4gram <- dt_all_grams[dt_all_grams$part1 == word3, ]
matched_4gram
matched_3gram <- dt_all_grams[dt_all_grams$part1 == word2, ]
matched_3gram
matched_2gram <- dt_all_grams[dt_all_grams$part1 == word1, ]
matched_2gram

input_5gram <- dt_all_grams[dt_all_grams$ngram == word4, ]
input_5gram
input_4gram <- dt_all_grams[dt_all_grams$ngram == word3, ]
input_4gram
input_3gram <- dt_all_grams[dt_all_grams$ngram == word2, ]
input_3gram
input_2gram <- dt_all_grams[dt_all_grams$ngram == word1, ]
input_2gram



if (nrow(matched_5gram) > 0) {
     head(round(matched_5gram$freq / input_5gram$freq[1], 3), 3)
     head(matched_5gram$part2, 3)
} else if (nrow(matched_4gram) > 0) {
     head(round(0.4 * matched_4gram$freq / input_4gram$freq[1], 3), 3)
     head(matched_4gram$part2, 3)
} else if (nrow(matched_3gram) > 0) {
     head(round(0.4 * 0.4 * matched_3gram$freq / input_3gram$freq[1], 3), 3)
     head(matched_3gram$part2, 3)
} else if (nrow(matched_2gram) > 0) {
     head(round(0.4 * 0.4 * 0.4 * matched_2gram$freq / input_2gram$freq[1], 3), 3)
     head(matched_2gram$part2, 3)
}




# Stupid Backoff Modified -------------------------------------------------


input <- tokenize(input)
input <- input[!is.na(match(input, GradyAugmented))]

word_intersect <- intersect(ls_all_grams, input)
input_mod <- tokenize(intersect(input, word_intersect))


input_mod


word10 <- create_ngram_back(tokenize(input_mod), n=10)
word6 <- create_ngram_back(tokenize(input_mod), n=6)
word5 <- create_ngram_back(tokenize(input_mod), n=5)
word4 <- create_ngram_back(tokenize(input_mod), n=4)
word3 <- create_ngram_back(tokenize(input_mod), n=3)
word2 <- create_ngram_back(tokenize(input_mod), n=2)
word1 <- create_ngram_back(tokenize(input_mod), n=1)



matched_5gram <- dt_all_grams[dt_all_grams$part1 == word4, ]
matched_5gram
matched_5gram <- dt_all_grams[dt_all_grams$part1 == word4, ]
matched_5gram
matched_4gram <- dt_all_grams[dt_all_grams$part1 == word3, ]
matched_4gram
matched_3gram <- dt_all_grams[dt_all_grams$part1 == word2, ]
matched_3gram
matched_2gram <- dt_all_grams[dt_all_grams$part1 == word1, ]
matched_2gram

input_5gram <- dt_all_grams[dt_all_grams$ngram == word4, ]
input_5gram
input_4gram <- dt_all_grams[dt_all_grams$ngram == word3, ]
input_4gram
input_3gram <- dt_all_grams[dt_all_grams$ngram == word2, ]
input_3gram
input_2gram <- dt_all_grams[dt_all_grams$ngram == word1, ]
input_2gram


if (nrow(matched_5gram) > 0) {
     head(round(matched_5gram$freq / input_5gram$freq[1], 3), 6)
     head(matched_5gram$part2, 6)
} else if (nrow(matched_4gram) > 0) {
     head(round(0.4 * matched_4gram$freq / input_4gram$freq[1], 3), 6)
     head(matched_4gram$part2, 6)
} else if (nrow(matched_3gram) > 0) {
     head(round(0.4 * 0.4 * matched_3gram$freq / input_3gram$freq[1], 3), 6)
     head(matched_3gram$part2, 6)
} else if (nrow(matched_2gram) > 0) {
     head(round(0.4 * 0.4 * 0.4 * matched_2gram$freq / input_2gram$freq[1], 3), 6)
     head(matched_2gram$part2, 6)
}


# Stupid Backoff Modified w/o stopwords -------------------------------------------------

input <- "I'd give anything to see arctic monkeys this"; "weekend"

input <- tokenize(input)
input <- input[!is.na(match(input, GradyAugmented))]

word_intersect <- intersect(ls_all_grams2, input)
input_mod <- intersect(input, word_intersect)
#input_mod <- input_mod[!input_mod %in% stopwords()]

input_mod




word10 <- create_ngram_back(tokenize(input_mod), n=10)
word6 <- create_ngram_back(tokenize(input_mod), n=6)
word5 <- create_ngram_back(tokenize(input_mod), n=5)
word4 <- create_ngram_back(tokenize(input_mod), n=4)
word3 <- create_ngram_back(tokenize(input_mod), n=3)
word2 <- create_ngram_back(tokenize(input_mod), n=2)
word1 <- create_ngram_back(tokenize(input_mod), n=1)



matched_5gram <- dt_all_grams2[dt_all_grams2$part1 == word4, ]
matched_5gram
matched_5gram <- dt_all_grams2[dt_all_grams2$part1 == word4, ]
matched_5gram
matched_4gram <- dt_all_grams2[dt_all_grams2$part1 == word3, ]
matched_4gram
matched_3gram <- dt_all_grams2[dt_all_grams2$part1 == word2, ]
matched_3gram
matched_2gram <- dt_all_grams2[dt_all_grams2$part1 == word1, ]
matched_2gram

input_5gram <- dt_all_grams2[dt_all_grams2$ngram == word4, ]
input_5gram
input_4gram <- dt_all_grams2[dt_all_grams2$ngram == word3, ]
input_4gram
input_3gram <- dt_all_grams2[dt_all_grams2$ngram == word2, ]
input_3gram
input_2gram <- dt_all_grams2[dt_all_grams$ngram == word1, ]
input_2gram


if (nrow(matched_5gram) > 0) {
     head(round(matched_5gram$freq / input_5gram$freq[1], 3), 3)
     head(matched_5gram$part2, 3)
} else if (nrow(matched_4gram) > 0) {
     head(round(0.4 * matched_4gram$freq / input_4gram$freq[1], 3), 3)
     head(matched_4gram$part2, 3)
} else if (nrow(matched_3gram) > 0) {
     head(round(0.4 * 0.4 * matched_3gram$freq / input_3gram$freq[1], 3), 3)
     head(matched_3gram$part2, 3)
} else if (nrow(matched_2gram) > 0) {
     head(round(0.4 * 0.4 * 0.4 * matched_2gram$freq / input_2gram$freq[1], 3), 3)
     head(matched_2gram$part2, 3)
}




