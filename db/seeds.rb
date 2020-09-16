# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless CheckupAppointment.count.positive?
  User.create([
    { email: 'amit11@yopmail.com', password: 'Test@123' },
    { email: 'tanu11@yopmail.com', password: 'Qwert@123' }
  ])
  Doctor.create([
    { name: 'Kabir Singh' },
    { name: 'Milkha Singh' }
  ])
  CheckupAppointment.create([
    { doctor: Doctor.first, start_time: '2020-09-17 10:30:00', end_time: '2020-09-17 15:30:00' },
    { doctor: Doctor.first, start_time: '2020-09-16 10:00:00', end_time: '2020-09-16 20:00:00' },
    { doctor: Doctor.first, start_time: '2020-09-16 15:00:00', end_time: '2020-09-16 19:00:00' },
    { doctor: Doctor.second, start_time: '2020-09-16 15:00:00', end_time: '2020-09-16 21:00:00' },
    { doctor: Doctor.second, start_time: '2020-09-17 17:30:00', end_time: '2020-09-17 21:30:00' }
  ])
end
