# OSU News Web Scraping

Gets news from OSU News website: https://news.osu.edu

### Setup
In this project the gem Mechanize used.

To install:
```
~$ bundle install
```

To run must redirect to osuwebnewsscraping directory:
```
~$ bundle exec ruby main.rb
```
or
```
~$ ruby main.rb
```

How program works:
When run, user will be prompt to enter a topic of interest that will be used to search all the articles that are related to the topic. Then user will choose which article to read from a list of articles. The content of the article will be printed and also the number of words in the article. You can also search if some key words you would like to find exist in the articles. User will be prompt whether to quit or search a new topic to read.
