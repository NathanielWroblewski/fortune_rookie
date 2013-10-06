# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'admin@admin.com', password: 'password')

Player.create(first_name:'Ha Ha', last_name:'Clinton-Dix', ipo: 89_00, draft_year: Time.now.year)
Player.create(first_name:'Jadeveon', last_name:'Clowney', ipo: 98_00, draft_year: Time.now.year)
Player.create(first_name:'Khalil', last_name:'Mack', ipo: 86_00, draft_year: Time.now.year)
Player.create(first_name:'Teddy', last_name:'Bridgewater', ipo: 86_00, draft_year: Time.now.year, position: 'QB', school: 'Louisville')
Player.create(first_name:'Brett', last_name:'Hundley', ipo: 91_00, draft_year: Time.now.year, position: 'QB', school: 'UCLA')

