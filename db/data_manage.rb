require_relative( '../models/customer')
require_relative( '../models/film')
require_relative( '../models/ticket')
require_relative( '../models/screening')

require( 'pry-byebug' )

Ticket.delete_all
Screening.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new({'name' => 'Dave Burnett', 'funds' => 85})
customer1.save()
customer2 = Customer.new({'name' => 'Dorris Borris', 'funds' => 50})
customer2.save()

film1 = Film.new({'title' => 'Batman'})
film1.save()
film2 = Film.new({'title' => 'James Bond'})
film2.save()
film3 = Film.new({'title' => 'Indiana Jones'})
film3.save()

screening1 = Screening.new({'film_id' => film1.id, 'screen_number' => 1, 'start_time' => '16:00', 'capacity' => 20})
screening2 = Screening.new({'film_id' => film2.id, 'screen_number' => 2, 'start_time' => '16:30', 'capacity' => 25})
screening3 = Screening.new({'film_id' => film3.id, 'screen_number' => 3, 'start_time' => '17:00', 'capacity' => 30})
screening4 = Screening.new({'film_id' => film1.id, 'screen_number' => 1, 'start_time' => '18:00', 'capacity' => 20})
screening5 = Screening.new({'film_id' => film2.id, 'screen_number' => 2, 'start_time' => '18:30', 'capacity' => 25})
screening6 = Screening.new({'film_id' => film3.id, 'screen_number' => 3, 'start_time' => '19:00', 'capacity' => 30})
screening1.save()
screening2.save()
screening3.save()
screening4.save()
screening5.save()
screening6.save()

# something is modifying the customer id values. 

ticket1 = Ticket.new({'film_id' => film1.id, 'customer_id' => customer1.id, 'screening_id' => screening1.id})
ticket1.save()
ticket2 = Ticket.new({'film_id' => film1.id, 'customer_id' => customer2.id, 'screening_id' => screening4.id})
ticket2.save()
ticket3 = Ticket.new({'film_id' => film2.id, 'customer_id' => customer2.id, 'screening_id' => screening2.id})
ticket3.save()
ticket4 = Ticket.new({'film_id' => film3.id, 'customer_id' => customer1.id, 'screening_id' => screening3.id})
ticket4.save()


binding.pry
nil
