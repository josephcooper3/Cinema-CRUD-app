require_relative('../db/SqlRunner')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @price = options['price'].to_i
    @id = options['id'] if options['id']
  end

  def save()
    sql = "INSERT INTO films (title, price)
    VALUES ($1, $2)
    RETURNING id
    "
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    results = SqlRunner.run(sql)
    return map_results_to_film(results)
  end

  def update()
    sql = "UPDATE films SET title = $1, price = $2
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end

def map_results_to_film(results)
  results.map { |result| Film.new(result) }
end
