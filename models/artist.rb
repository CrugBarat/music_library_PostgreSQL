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
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
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

  def self.find_by_id(id)
    sql = "SELECT * FROM artists
           WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    artist = Artist.new(results.first())
    return artist
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM artists
           WHERE name = $1"
    values = [name]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    artist = Artist.new(results.first())
    return artist
  end

end
