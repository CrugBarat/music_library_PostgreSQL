require('pry-byebug')
require_relative('../models/album.rb')
require_relative('../models/artist.rb')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'name' => 'Nirvana'})

artist2 = Artist.new({'name' => 'Korn'})

artist3 = Artist.new({'name' => 'Nathan Fake'})

artist1.save()
artist2.save()
artist3.save()


album1 = Album.new({'title' => 'Nevermind',
                    'genre' => 'Genre',
                    'artist_id' => artist1.id })

album2 = Album.new({'title' => 'Untouchables',
                    'genre' => 'Nu-Metal',
                    'artist_id' => artist2.id })

album3 = Album.new({'title' => 'Drowning in a Sea of Love',
                    'genre' => 'Electronic',
                    'artist_id' => artist3.id })

album4 = Album.new({'title' => 'Steam Days',
                    'genre' => 'Electronic',
                     'artist_id' => artist3.id })

album1.save()
album2.save()
album3.save()
album4.save()


binding.pry
nil
