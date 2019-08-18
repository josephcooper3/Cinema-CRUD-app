require('pry')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({
  'name' => 'Mariette',
  'funds' => 30
})

customer2 = Customer.new({
  'name' => 'Jean',
  'funds' => 20
})

customer1.save()
customer2.save()

film1 = Film.new({
  'title' => 'The Lion King',
  'price' => 12
})

film2 = Film.new({
  'title' => 'Toy Story 4',
  'price' => 10
})

film3 = Film.new({
  'title' => 'Yesterday',
  'price' => 10
})

film1.save()
film2.save()
film3.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
})

ticket2 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id
})

ticket3 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id
})

ticket1.save()
ticket2.save()
ticket3.save()

binding.pry
nil
