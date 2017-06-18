
WoPr Shiny App
========================================================
autosize: true
Coursera Data Science Capstone Project




WoPr - A Word Prediction App
========================================================

WoPr [whopper] : [Shiny App]()

- a smart app which predicts the next word while typing

How it works
- type in a word or a phrase into the text field
- three words will be suggested on the go



Database and Prediction Algorithm
========================================================

Pre-work and testing
- used real world text from blogs, twitter and news sites to prepare a clean word sequence dataset
- cleaned raw text and created n-word-grams as a foundation for prediction algorithm
- coded word prediction algorithm: Stupid Backoff [(Brants *et al.*, 2007)](http://www.aclweb.org/anthology/D07-1090.pdf)
- [benchmarked](https://github.com/hfoffani/dsci-benchmark) to tune parameters (database size, storage type, n-grams and frequency, algorithm, code) for best performance 

To make the application usable focus was put on finding the right balance between accuracy and speed 
-> **Fastest response and highest accuracy using**
- 5% of total text database / 2- to 5-word-grams 
- Supid Backoff prediction algorithm
- simplify data structure, vectorization and data.table


Application Performance
========================================================
The prediction performance was benchmarked using code from [J.H./H.F.](https://github.com/jan-san/dsci-benchmark)

Overall top-1, top-3 precision and runtime are above average compared to class peers [(forum)](https://www.coursera.org/learn/data-science-project/discussions). 
Stupid backoff algorith is performing well! 

Overall top-3 score:     15.77 %
Overall top-1 precision: 11.37 %
Overall top-3 precision: 19.53 %
Average runtime:         32.66 msec
Number of predictions:   28464
Total memory used:       47.48 MB

Dataset details
 Dataset "blogs" (599 lines, 14587 words, hash 14b3c593e543eb8b2932cf00b646ed653e336897a03c82098b725e6e1f9b7aa2)
  Score: 15.55 %, Top-1 precision: 11.10 %, Top-3 precision: 19.33 %
 Dataset "tweets" (793 lines, 14071 words, hash 7fa3bf921c393fe7009bc60971b2bb8396414e7602bb4f409bed78c7192c30f4)
  Score: 16.00 %, Top-1 precision: 11.64 %, Top-3 precision: 19.73 %


========================================================


