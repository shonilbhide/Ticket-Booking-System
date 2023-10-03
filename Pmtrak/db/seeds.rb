# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb

# Create admin
Admin.destroy_all
Admin.create(username: "admin",name:"admin", email: "admin@example.com", password: "Admin@pass123",phone_number: "999-999-9999",credit_number: "1234-1234-1234-1234")
