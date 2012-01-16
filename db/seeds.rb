# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
password_salt = BCrypt::Engine.generate_salt
password_hash = BCrypt::Engine.hash_secret("admin", password_salt)
User.create(:email => "admin@admin.com", :password_hash => password_hash, :password_salt => password_salt)