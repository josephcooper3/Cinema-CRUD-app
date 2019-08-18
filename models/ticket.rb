require_relative('../db/SqlRunner')

class Ticket

  attr_accessor :customer_id, :screening_id
  attr_reader :id

  def initialize(options)
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, screening_id)
    VALUES ($1, $2)
    RETURNING id
    "
    values = [@customer_id, @screening_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    results = SqlRunner.run(sql)
    return map_results_to_ticket(results)
  end

  def update()
    sql = "UPDATE tickets
    SET customer_id = $1, screening_id = $2
    WHERE id = $3"
    values = [@customer_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end

def map_results_to_ticket(results)
  results.map { |result| Ticket.new(result) }
end
