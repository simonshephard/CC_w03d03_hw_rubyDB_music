require_relative('album')

class Artist

  attr_reader :id, :name, :genre, :artist_id

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
    @genre = details['genre']
    @artist_id = details['artist_id']
  end

end
