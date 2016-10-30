### Exercise 2 ###

# As you noticed, it often takes multiple queries to retrieve the desired information.
# This is a perfect situation in which writing a function will allow you to better structure your
# code, and give a name to a repeated task.
install.packages('jsonlite')
install.packages('curl')
library(jsonlite)
setwd('~/Desktop/m10-apis/exercise-2/')


# Write a function that allows you to specify an artist, and returns the top 10 tracks of that artist

TopTrackSearch <- function(artist) {
  
  base <- 'http://api.spotify.com/v1/'
  
  artist.query <- paste0(base, 'search?', 'q=', artist, '&type=artist')
  
  artist.info <- fromJSON(artist.query)
  artist.id <- artist.info$artists$items$id[1]
  
  album.query <- paste0(base, 'artists/', artist.id, '/top-tracks?country=US')
  top.tracks <- fromJSON(album.query)
  return(top.tracks$tracks)
  
}


# What are the top 10 tracks by Nelly?

top.nelly <- TopTrackSearch('Nelly')

save(top.nelly, file = "nelly_tracks.Rdata")

### Bonus ### 
# Write a function that allows you to specify a search type (artist, album, etc.), and a string, 
# that returns the album/artist/etc. page of interest

data <- fromJSON('https://api.spotify.com/v1/search?q=adele&type=artist')
Search <- function(type, string) {
  
  base <- 'https://api.spotify.com/v1/'
  search <- paste0(base, 'search?', 'q=', string, '&type=', type)
  info <- fromJSON(search)
  return(info)
}
# Search albums with the word "Sermon"

