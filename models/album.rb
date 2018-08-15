require('pg')
require_relative('../db/sql_runner')
require_relative('./artist')

class Album

  attr_reader :id
  attr_accessor :name, :genre, :artist_id

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
    @genre = details['genre']
    @artist_id = details['artist_id']
  end

  def self.all
    sql = "SELECT * FROM albums;"
    albums = SqlRunner.run(sql)
    return albums.map {|album| Album.new(album)}
  end

  def self.delete_all
    sql = "DELETE FROM albums;"
    values = []
    result = SqlRunner.run(sql, values)
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM albums
    WHERE name = $1;"
    values = [name]
    result = SqlRunner.run(sql, values)
    return Album.new(result[0])
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM albums
    WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Album.new(result[0])
  end

  def save
    sql = "INSERT INTO albums
      (name, genre, artist_id)
      VALUES
      ($1, $2, $3)
      RETURNING id;"
    values = [@name, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE albums
    SET
    (name, genre, artist_id)
    = ($1, $2, $3)
    WHERE id = $4;"
    values = [@name, @genre, @artist_id, @id]
    result = SqlRunner.run(sql, values)
  end

  def artists
    sql = "SELECT * FROM artists
    WHERE id = $1;"
    values = [@artist_id]
    artists = SqlRunner.run(sql, values)
    return artists.map {|artist| Artist.new(artist)}
  end

end
