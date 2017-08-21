require_relative("../db/sql_runner")
require_relative("./customer")


class Ticket

  attr_reader :id
  attr_accessor :film_id, :customer_id, :screening_id


  def initialize ( options )
    @id = options['id'].to_i
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
    @screening_id  = options['screening_id'].to_i
    @customer_funds = 0
    @ticket_price = 10
  end

  def save()
    sql = "INSERT INTO tickets (film_id, customer_id, screening_id) VALUES ($1, $3, $2) RETURNING id;"
    values = [@film_id, @customer_id, @screening_id]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
      # REFACTOR?
    sql2 = "SELECT funds FROM customers WHERE id = $1"
    values2 = [@customer_id]
    user2 = SqlRunner.run(sql2, values2).first
    @customer_funds = user2['funds'].to_i - @ticket_price

    sql3 = "UPDATE customers SET funds = $2 WHERE id = $1"
    values3 = [@customer_id, @customer_funds]
    result = SqlRunner.run(sql3, values3)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    result = tickets.map { |ticket| Ticket.new( ticket ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    values = []
    SqlRunner.run(sql, values)
  end


end
