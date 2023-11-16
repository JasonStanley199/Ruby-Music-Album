require './input_functions'

#class album
class Album
    attr_accessor :albumid, :title, :artist, :genre, :tracks

def initialize (albumid, title, artist, genre, tracks)
	@albumid = albumid
	@title = title
	@artist = artist
	@genre = genre
    @tracks = tracks
	end
end

#class track
class Track
	attr_accessor :name, :location

	def initialize (name, location)
		@name = name
		@location = location
	end
end


#read tracks
def read_tracks(music_file)
	count = music_file.gets().to_i()
	tracks = Array.new()
	i = 0
	while i < count  
	  track = read_track(music_file)
	  tracks << track
	  i += 1
	end
	return tracks
end	

#read track
def read_track(music_file)
	
	track_name = music_file.gets.chomp
	track_location = music_file.gets.chomp
	track = Track.new(track_name, track_location)
	return track
end

#read albums
def read_albums(music_file)
	count = music_file.gets().to_i()
	albums = Array.new()
	i = 0
	while i < count  
	  album = read_album(music_file)
	  albums << album
	  i += 1
	end
	return albums
end	

#read album
def read_album(music_file)
	album_albumid = music_file.gets.chomp
	album_title = music_file.gets.chomp
	album_artist = music_file.gets.chomp
	album_genre = music_file.gets.chomp
	tracks = read_tracks(music_file)
	album = Album.new(album_albumid, album_title, album_artist, album_genre, tracks)
	return album
end

#print track
def print_track(track)
	puts(track.name)
  	puts(track.location)
end

#print tracks

def print_tracks(tracks)
	count = tracks.length
  	i = 0
  	while i < count
  	print_track(tracks[i])
  	i += 1
  	end
end

#print album
def print_album(album)
	puts (' ')
	puts('Album ID: ' + album.albumid.to_s)
	puts(album.title.to_s)
	puts(album.artist.to_s)
	puts(album.genre.to_s)
	print_tracks(album.tracks)
end

#print albums
def print_albums(albums)
	count = albums.length
  	i = 0
	while i < count
  	print_album(albums[i])
	  i += 1
  	end
end

#main
def load_album()
	music_file = File.new("albums.txt", "r")
	albums = read_albums(music_file)
	music_file.close()
	print_albums(albums)
end


load_album()
