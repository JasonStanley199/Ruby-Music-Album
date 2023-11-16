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

def load_album()
  puts ('Enter File Name: ')
  filename = gets.chomp()
    case filename
    when "albums.txt"
      music_file = File.new("albums.txt", "r")
      albums = read_albums(music_file)
      puts('------------------')
      puts ('Albums Loaded')
      read_string("Press enter to continue")

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

#search function
def search_for_track_name(albums, search_string)
  index = 0
  found_index = -1
  while (index < albums.length)
     if (albums[index].genre.chomp == search_string)
     found_index = index
     print_singular_album(albums[found_index])
     end
     index += 1	
   end
   return found_index	
end

#print track only
def print_track_only(track)
    puts(track.trackid + ". " + track.name)
end

#print tracks
def print_singular_tracks(tracks)
  count = tracks.length
  i = 0
  while i < count
    print_track_only(tracks[i])
    i += 1
  end
end

#singular album menu option 3
def print_singular_album1(album)
    print_singular_tracks(album.tracks)
end

#play track name menu option 3
def play_track_name(albums, play_string)
  index = 0
  found_index = -1
  while (index < albums.length)
     if (albums[index].albumid.chomp == play_string)
     found_index = index
     print_singular_album1(albums[found_index])
     end
     index += 1	
   end
   return found_index	
end

def check_albumid(albums, new_title)
  index = 0
  found_index = -1
  while (index < albums.length)
    if (albums[index].albumid.chomp == new_title)
    found_index = index
    end
    index += 1	
  end
  return found_index	
end

else
  puts('------------------')
  puts ('No Albums Found')
  read_string("Press enter to continue")
end
return albums
end



# Main Menu
def main()
  finished = false
  begin
    puts('')
    puts("Main Menu:")
    puts("1 - Read in Album")
    puts("2 - Display Album Info")
    puts("3 - Play Album")
    puts("4 - Update Album")
    puts("5 - Exit")
    choice = read_integer_in_range("Please enter your choice:", 1, 5) 
    case choice
    when 1
      load_album()
    when 2
      puts("Display Album Info ")
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
          puts('------------------')
          puts("Play Album")
          puts("Play by ID")
          play_string = read_string("Enter the album ID you wish to play: ")
          if play_string.to_i > albums.length.to_i
            puts "Album not found"
            read_string("Press enter to continue")
          else
          index = play_track_name(albums, play_string)
          choice = read_integer_in_range("Please enter your choice:", 1, 2)
          case choice
          when 1 
            puts ('Playing Song')
            sleep(3)
            puts ('Successfully Played')
            read_string("Press enter to continue")
          when 2
            puts ('Playing Song')
            sleep(3)
            puts ('Successfully Played')
            read_string("Press enter to continue")
          end
        end
        when 4
          puts("Update Album Info")
          update_albumid = read_integer("Enter the album ID you wish to update (0-4): ")
          if update_albumid.to_i > albums.length.to_i
            puts "Album not found"
            read_string("Press enter to continue")
          else
            puts("1 - Update album title")
            puts("2 - Update album genre")
            choice = read_integer_in_range("Select the info you want to change:", 1, 2)
            case choice
            when 1
              new_title = read_string ("Enter new album title:")
              index = check_albumid(albums, new_title)
              albums[update_albumid].title = new_title
            when 2 
              new_genre = read_string ("Enter new album genre (1-5): ")
              albums[update_albumid].genre = new_genre
            end
          end
        when 5
        finished = true
        end
  end until finished
end

main()
