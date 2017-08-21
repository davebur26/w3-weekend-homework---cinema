require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :film_id, :screen_number, :start_time, :capacity

  def initialize ( options )
    @id = options['id'].to_i
    @film_id = options['film_id'].to_i
    @screen_number = options['screen_number'].to_i
    @start_time  = options['start_time'].to_i
    @capacity = options['capacity'].to_i
  end


  def save()
    sql = "INSERT INTO screenings (film_id, screen_number, start_time, capacity) VALUES ($1, $2, $3, $4) RETURNING id;"
    values = [@film_id, @screen_number, @start_time, @capacity]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    values = []
    screenings = SqlRunner.run(sql, values)
    result = screening.map { |screening| Screening.new( screening ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.map_items( rows )
    return rows.map{ |row| Screening.new(row) }
  end


end
