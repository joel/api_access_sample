# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(:email => 'joel.azemar@gmail.com', :password => 'secret', :password_confirmation => 'secret')
['google', 'live'].each do |provider|
  user.providers.create!(:name => provider)
end