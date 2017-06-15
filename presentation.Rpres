
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
- three words will be suggested immediately



Database and Model
========================================================

Pre-work and testing
- used real world text from blogs, twitter and news sites to prepare a clean word sequence dataset
- created n-word-grams as a foundation for prediction algorithm
- coded word prediction algorithms: Stupid Backoff, Kneser-Ney [(Brants *et al.*, 2007)](http://www.aclweb.org/anthology/D07-1090.pdf)
- benchmarked^1 all above parameters (database size, storage type, n-grams and frequency, algorithm, code) for best performance 

To make the application usable focus was put on finding the right balance between accuracy and speed. 
-> **Fastest response and highest accuracy using**
- 5% of total text database, 
- 2- to 5-grams occuring at least 3 times, and
- Supid Backoff 


Application Performance
========================================================
The prediction performance was benchmarked using code from [J.S. and H.F.](https://github.com/jan-san/dsci-benchmark)


After fine tuning using "prdct" with "input":
Overall top-3 score:     14.45 %
Overall top-1 precision: 11.37 %
Overall top-3 precision: 17.11 %
Average runtime:         208.51 msec
Number of predictions:   467
Total memory used:       2886.28 MB

After fine tuning using "prdct" with "input_mod":
Overall top-3 score:     14.39 %
Overall top-1 precision: 11.18 %
Overall top-3 precision: 17.30 %
Average runtime:         249.86 msec
Number of predictions:   467
Total memory used:       2886.28 MB





XYZ
========================================================


