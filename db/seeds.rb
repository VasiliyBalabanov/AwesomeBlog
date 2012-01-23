# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(:email => "hellofrompiter@gmail.com", :password => "password", :is_admin => 1 )
Post.create(:title => "Welcome!", :body => "Start writing right now.", :user_id => 1)