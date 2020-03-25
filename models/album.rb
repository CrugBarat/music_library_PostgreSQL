require_relative('../db/sql_runner.rb')

class Album

  attr_accessor :title, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums (title, genre, artist_id)
           VALUES ($1, $2, $3)
           RETURNING id"
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    album_hashes = SqlRunner.run(sql)
    album_objs = album_hashes.map {|album| Album.new(album)}
    return album_objs
  end

  def artist()
    sql = "SELECT * FROM artists
           WHERE id = $1"
    values = [@artist_id]
    artist_hashes =  SqlRunner.run(sql, values)[0]
    artist = Artist.new(artist_hashes)
    return artist
  end

  def update()
    sql = "UPDATE albums SET (title, genre, artist_id)
           = ($1, $2, $3)
           WHERE id = $4"
    values =[@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM albums
           WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    album_hash = results.first()
    album = Album.new(album_hash)
    return album
  end

  def self.find_by_title(title)
    sql = "SELECT * FROM albums
           WHERE title = $1"
    values = [title]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    album_hash = results.first()
    album = Album.new(album_hash)
    return album
  end

  def self.find_by_genre(genre)
    sql = "SELECT * FROM albums
           WHERE genre = $1"
    values = [genre]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    album_hash = results.first()
    album = Album.new(album_hash)
    return album
  end

end
