require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize ( options )
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id;"
    values = [@name, @funds]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end

  def update()
    sql = "UPDATE customers SET name = $2 WHERE id = $1"
    values = [@id, @name, @funds]
    result = SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def films_watched()
    sql = "
      SELECT films.* FROM films
      INNER JOIN tickets ON tickets.film_id = films.id
      WHERE customer_id = $1;
      "
    values = [@id]
    customer_films = SqlRunner.run(sql, values)
    result = Film.map_items(customer_films)
    return result
  end

  def self.map_items( rows )
    return rows.map{ |row| Customer.new(row) }
  end

  def number_of_films_watched()
    number_of_films_watched = films_watched().length
    return "#{@name} has watched #{number_of_films_watched} films"
  end


end
