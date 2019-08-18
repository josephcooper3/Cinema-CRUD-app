require_relative('../db/SqlRunner')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @funds = options['funds'].to_i
    @id = options['id'] if options['id']
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
    VALUES ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    results = SqlRunner.run(sql)
    return map_results_to_customer(results)
  end

  def update()
    sql = "UPDATE customers SET name = $1, funds = $2
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def films_booked()
    sql = "SELECT * FROM films
    INNER JOIN tickets ON films.id = tickets.film_id
    WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return map_results_to_film(results)
  end

  def spend(price)
    return nil if price > @funds
    @funds -= price
  end

  def buy_ticket(film)
    return nil if spend(film.price) == nil
    ticket = Ticket.new({
      'customer_id' => @id,
      'film_id' => film.id
    })
    ticket.save()
    self.update()
  end

end

def map_results_to_customer(results)
  results.map { |result| Customer.new(result) }
end

def map_results_to_film(results)
  results.map { |result| Film.new(result) }
end
