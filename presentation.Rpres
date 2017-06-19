
WoPr Shiny App
========================================================
autosize: true
author: R. Engelke
Coursera Data Science Capstone Project




WoPr - A Word Prediction App
========================================================

WoPr [whopper] : [Shiny App](https://rue2006.shinyapps.io/wopr/)

- a smart app which predicts the next word while typing


How it works
- type in a word or a phrase into the text field
- three words will be suggested immediately
- the suggestion will be refreshed on the go when parts of the next word are entred
- completing a word or hitting space gives the prediction of the next word
- the algorithm is very fast but the internet connection etc. might be slow: so don't type too fast



Database and Workflow
========================================================

Pre-work and testing
- used real world text from blogs, twitter and news sites to prepare a clean word sequence dataset
- cleaned raw text and created n-word-grams as a foundation for prediction algorithm
- coded word prediction algorithm: Stupid Backoff
- [benchmarked](https://github.com/hfoffani/dsci-benchmark) to tune parameters (database size, storage type, n-grams and frequency, algorithm, code) for best performance 

To make the application usable focus was put on finding the right balance between accuracy and speed 
-> **Fastest response and highest accuracy using**
- 5% of total text database / 2- to 5-word-grams 
- Supid Backoff prediction algorithm
- simplify data structure, vectorization and data.table


Prediction Algorithm
========================================================

**Stupid Backoff** algorithm  [(Brants *et al.*, 2007)](http://www.aclweb.org/anthology/D07-1090.pdf) was used to predict the next word   
Description: Looks up longest n-gram then goes to n-1-gram level if no matches were found. Calculates the prediction score which is the frequency of n-gram occurence in the n-gram dataset. This frequency is multiplied by a factor of 0.4 with each n-1-gram step.
- very good prediction and inexpensive in calculation 
- very similar results compared to more sophisticated algorithms like Kneser-Ney smoothing or Markov Chain model based prediction ([Coursera forum](https://www.coursera.org/learn/data-science-project/discussions), [Brants *et al.*, 2007](http://www.aclweb.org/anthology/D07-1090.pdf))



Application Performance
========================================================
The prediction performance was benchmarked using code from [J.H./H.F.](https://github.com/jan-san/dsci-benchmark)   

Good performance (19.5 % top-3 precision at 32.7 msec) considering that 48 % of the words are difficult to predict since these are not even found in the GraudyAugmented dictionary!   

<font size="6"> 
Overall top-3 score:     15.77 %   
Overall top-1 precision: 11.37 %   
Overall top-3 precision: 19.53 %   
Average runtime:         32.66 msec   
Number of predictions:   28464   
Total memory used:       47.48 MB   
</font>    
<font size="4"> 
Dataset details
 Dataset "blogs" (599 lines, 14587 words, hash 14b3c593e543eb8b2932cf00b646ed653e336897a03c82098b725e6e1f9b7aa2)   
 Dataset "tweets" (793 lines, 14071 words, hash 7fa3bf921c393fe7009bc60971b2bb8396414e7602bb4f409bed78c7192c30f4)   
</font> 



