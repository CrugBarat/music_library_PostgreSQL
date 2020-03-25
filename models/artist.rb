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
    customer_hash = returned_array[0]
    id_string = customer_hash['id']
    @id = id_string.to_i
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

end
