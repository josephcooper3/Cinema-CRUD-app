require_relative('../db/SqlRunner')
require_relative('./film')

class Screening

  attr_accessor :film_id, :time
  attr_reader :id

  def initialize(options)
    @film_id = options['film_id'].to_i
    @time = options['time'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO screenings (film_id, time)
    VALUES ($1, $2)
    RETURNING id
    "
    values = [@film_id, @time]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    results = SqlRunner.run(sql)
    return map_results_to_screening(results)
  end

  def update()
    sql = "UPDATE screenings SET film_id = $1, time = $2
    WHERE id = $3"
    values = [@film_id, @time, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def film
    sql = "SELECT * FROM films WHERE films.id = $1"
    values = [@film_id]
    film = SqlRunner.run(sql, values)
    return Film.new(film[0])
  end

end

def map_results_to_screening(results)
  results.map { |result| Screening.new(result) }
end
