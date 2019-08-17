require('pry')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')

Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({
  'name' => 'Mariette',
  'funds' => 30
})

customer1.save()

film1 = Film.new({
  'title' => 'The Lion King',
  'price' => 12
})

film1.save()

binding.pry
nil
