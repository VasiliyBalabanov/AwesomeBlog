# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(:email => "hellofrompiter@gmail.com", :password => "password" )
u = User.first
u.is_admin = true
u.save
Post.create(:title => "Welcome!", :body => "Start writing right now.", :user_id => 1)