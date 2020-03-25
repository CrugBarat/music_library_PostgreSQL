require_relative('../db/sql_runner.rb')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (name)
           VALUES ($1)
           RETURNING *"
    values = [@name]
    returned_array = SqlRunner.run(sql, values)
    artist_hash = returned_array[0]
    id_string = artist_hash['id']
    @id = id_string.to_i
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artist_hashes = SqlRunner.run(sql)
    artist_objs = artist_hashes.map {|artist| Artist.new(artist)}
    return artist_objs
  end

  def album()
    sql = "SELECT * FROM albums
           WHERE artist_id = $1"
    values = [@id]
    album_hashes = SqlRunner.run(sql, values)
    album_objs = album_hashes.map {|album| Album.new(album)}
    return album_objs
  end

  def update()
    sql = "UPDATE artists SET (name) = ($1)
           WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM artists
           WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    artist_hash = results.first()
    artist = Artist.new(artist_hash)
    return artist
  end

end
