require('pry-byebug')
require_relative('./models/album')
require_relative('./models/artist')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'name' => 'Jim'})
artist2 = Artist.new({'name' => 'Ray'})
artist3 = Artist.new({'name' => 'John'})
artist4 = Artist.new({'name' => 'Robbie'})

artist1.save()
artist2.save()
artist3.save()
artist4.save()

album1 = Album.new({
  'name' => 'The Doors',
  'genre' => 'Rock',
  'artist_id' => artist1.id
})
album2 = Album.new({
  'name' => 'Strange Days',
  'genre' => 'Rock',
  'artist_id' => artist2.id
})
album3 = Album.new({
  'name' => 'Soft Parade',
  'genre' => 'Rock',
  'artist_id' => artist1.id
})
album4 = Album.new({
  'name' => 'LA Woman',
  'genre' => 'Rock',
  'artist_id' => artist2.id
})

album1.save()
album2.save()
album3.save()
album4.save()


binding.pry
nil
