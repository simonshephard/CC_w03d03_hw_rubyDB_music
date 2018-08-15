require_relative('album')

class Artist

  attr_reader :id, :name, :genre, :artist_id

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
  end

  def self.all()
    sql = "SELECT * FROM artists;"
    artists = SqlRunner.run(sql)
    return artists.map {|artist| Artist.new(artist)}
  end

  def self.delete_all
    sql = "DELETE FROM artists"
    values = []
    result = SqlRunner.run(sql, values)
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM artists
    WHERE name = $1"
    values = [name]
    result = SqlRunner.run(sql, values)
    return Artist.new(result[0])
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM artists
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Artist.new(result[0])
  end

  def save()
    sql = "INSERT INTO artists
      (name)
      VALUES
      ($1)
      RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

  def albums
    sql = "SELECT * FROM albums
    WHERE artist_id = $1"
    values = [@id]
    albums = SqlRunner.run(sql, values)
    return albums.map {|album| Album.new(album)}
  end

end
