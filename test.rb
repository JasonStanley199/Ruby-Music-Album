require './input_functions'

module Genre
  POP, FOLK, HIPHOP, RNB, JPOP = *1..5
end

$genre_names = ['Null', 'Pop', 'Folk', 'HipHop', 'RNB', 'JPop']

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
  attr_accessor :trackid, :name
  
  def initialize (trackid, name)
    @trackid = trackid
    @name = name
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
  track_trackid = music_file.gets.chomp
  track_name = music_file.gets.chomp
  track = Track.new(track_trackid, track_name)
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
	puts($genre_names[album.genre.to_i])
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

#print album singular
def print_singular_album(album)
	puts (' ')
	puts('Album ID: ' + album.albumid.to_s)
	puts(album.title.to_s)
	puts(album.artist.to_s)
	puts($genre_names[album.genre.to_i])
	print_tracks(album.tracks)
end

#update album function
def update_album(albums, update_albumid)
    puts ('1 - Update Album Title')
    puts ('2 - Update Album Genre')
    choice = read_integer_in_range("Please enter your choice:", 1, 2)
    case choice
    when 1
      index = 0
      found_index = -1
      while (index < albums.length)
        if (albums[index].albumid.chomp == update_albumid)
        found_index = index
        updated_title = read_string("Enter new title: ")
        music_file.close
        end
        index += 1	
      end
    return found_index	
    when 2
      index = 0
      found_index = -1
      while (index < albums.length)
        if (albums[index].albumid.chomp == update_albumid)
        found_index = index
        updated_genre = read_integer("Enter new genre(1-5): ")
          if updated_genre < 6
          print_singular_updated_album_genre(albums[found_index], updated_genre)
          end
        end
        index += 1	
      end
    return found_index
    end
  end

def main()
    finished = false
    begin
      puts('')
      puts("Main Menu:")
      puts("1 - Read in Album")
      puts("2 - Display Album Info")
      puts("3 - Update Album")
      puts("5 - Exit")
      choice = read_integer_in_range("Please enter your choice:", 1, 5) 
      case choice
      when 1
        puts ('Enter File Name: ')
        filename = gets.chomp()
          case filename
          when "albums.txt"
            music_file = File.new("albums.txt", "r")
            albums = read_albums(music_file)
            puts('------------------')
            puts ('Albums Loaded')
            read_string("Press enter to continue")
          else
            puts('------------------')
            puts ('No Albums Found')
            read_string("Press enter to continue")
          end
      when 2
        puts("Display Album Info")
        puts("1 - Display All Album")
        puts("2 - Display Album by Genre")
        choice = read_integer_in_range("Please enter your choice:", 1, 2)
        case choice
          when 1
            print_albums(albums)
            read_string("Press enter to continue")
          when 2
            puts("Select Album Genre")
            puts("1 - Pop")
            puts("2 - Folk")
            puts("3 - Hip-Hop")
            puts("4 - R&B")
            puts("5 - J-Pop")
            search_string = read_string("Enter the genre you wish to find: ") 
            if search_string.to_i > 5
              puts ('Genre not found')
              read_string("Press enter to continue")
            else
            index = search_for_track_name(albums, search_string)
            if index > -1
              puts("")
              read_string("Press enter to continue")
            end
          end
          end
          when 3
            puts("Update Album Info")
            #music_file = File.new("albums.txt", "w")
            update_albumid = read_string("Enter the album ID you wish to update: ")
            index = update_album(albums, update_albumid)
          when 5
            finished = true
          end
    end until finished
  end
  
  main()