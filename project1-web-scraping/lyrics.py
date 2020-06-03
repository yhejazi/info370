from bs4 import BeautifulSoup as bs
import requests as r
import re
from nltk.tokenize import sent_tokenize, word_tokenize
from nltk.corpus import stopwords
from collections import Counter
import csv

def get_songs(artist):
    """Takes in an artist and returns a dictionary of songs for that artist with their url 
    from lyrics.com"""
    url = 'https://www.lyrics.com/artist/' + artist
    content = r.get(url)
    soup = bs(content.text, 'html.parser')
    songtables = soup.find_all('tbody')

    # get all the songs and urls on the artist page
    songs = {}
    for table in songtables:
        rawsongs = table.find_all('tr')
        for rawsong in rawsongs:
            songs[rawsong.td.text] = 'https://www.lyrics.com' + rawsong.td.a.attrs['href']
    return songs

def get_song_info(songs, artist):
    """Takes in an artist and a dictionary of songs and their urls and returns a list of dictionaries 
    with info about the songs, including: title, artist, album, lyrics, most common word, 
    word count"""
    result = []
    for title, url in songs.items():
        content = r.get(url)
        soup = bs(content.text, 'html.parser')

        # get song info (artist, album, lyrics, most common word, word count) from song page
        meta = [tag.attrs['content'] for tag in soup.find_all('meta') if 'name' 
                in tag.attrs and tag.attrs['name'] == 'description']
        matches = re.match('.*by (.+) from the (.+) album', meta[0])
        artist = artist
        album = matches.group(2)
        lyrics = soup.find(id='lyric-body-text').text
        words = lyrics.split() # list of lyrics
        common_word = find_most_common_word(words)
        wordcount = len(words)
        result.append({'artist': artist, 'album': album, 'title': title, 'url': url, 
                'lyrics': lyrics, 'wordcount': wordcount, 'most_common': common_word})
    return result

def find_most_common_word(words):
    """Takes in a list of words and returns the most common word w/o stop words"""
    stopWords = set(stopwords.words('english'))
    wordsFiltered = []
    for w in words:
        # exclude stop words
        if w not in stopWords:
            wordsFiltered.append(w)
    cnt = Counter(wordsFiltered)
    return cnt.most_common(1)[0][0]

def save_data(song_data, artist_name):
    """Takes in an artist and a list of dictionaries song data and creates a csv output file 
    of the data"""
    output = open(artist_name + '.csv', 'w')
    with output:
        writer = csv.writer(output)
        writer.writerow(['artist', 'album', 'title', 'url', 'lyrics', 'wordcount', 'most_common'])
        writer.writerows([song.values() for song in song_data])
