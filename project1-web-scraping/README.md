# Song Lyrics Web Scraper

This is a simple web scraper library to collect and process song lyrics from [lyrics.com](http://lyrics.com). This project delivers:
1. A set of functions necessary for scraping the lyrics of a specific artist
2. An example implementation of using library functions in this Jupyter Notebook
3. A file of example output from demo notebook (in a .csv file)

The web scraper is able to grab all songs of an artist the user defines, and info about each song, including __album name__, __song title__, __lyrics URL__, __lyrics__, __song word count__, and __most common non-stop word__. 

*Scraping data*:
* Given an artist, identifies all of their albums, songs, and links to songs
* Given a set of song links, collects the lyrics to each song 

*Processing data*:
* Counts the number of words in each song
* Identifies the most common word that is not a "stop word""

__Library functions__:
get_songs: Takes in an artist and returns a dictionary of songs for that artist with their url from lyrics.com

get_song_info: Takes in an artist and a dictionary of songs and their urls and returns a list of dictionaries with info about the songs, including: title, artist, album, lyrics, most common word, word count

find_most_common_word: Takes in a list of words and returns the most common word without stop words

save_data: Takes in an artist and a list of dictionaries song data and creates a csv output file of the data


