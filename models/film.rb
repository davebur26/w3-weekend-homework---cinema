require_relative("../db/sql_runner")


class Film

  attr_reader :id
  attr_accessor :title

  def initialize ( options )
    @id = options['id'].to_i
    @title = options['title']
  end

  def save()
    sql = "INSERT INTO films (title) VALUES ($1) RETURNING id;"
    values = [@title]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new( film ) }
    return result
  end

  def update()
    sql = "UPDATE films SET title = $2 WHERE id = $1"
    values = [@id, @title]
    result = SqlRunner.run(sql, values)
  end



  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

  def customers_watched()
    sql = "
      SELECT customers.* FROM customers
      INNER JOIN tickets ON tickets.customer_id = customers.id
      WHERE film_id = $1;
      "
    values = [@id]
    customer_films = SqlRunner.run(sql, values)
    result = Customer.map_items(customer_films)
    return result
  end

  def number_of_customers_watching()
    number_of_customers_watching = customers_watched().length
  end

  def self.map_items( rows )
    return rows.map{ |row| Film.new(row) }
  end

end
