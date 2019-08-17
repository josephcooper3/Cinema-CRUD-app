require('pry')
require_relative('./models/customer.rb')

customer1 = Customer.new({
  'name' => 'Mariette',
  'funds' => 30
})

customer1.save()

binding.pry
nil
