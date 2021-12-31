# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(name: "user1", email: "user_one@example.com", password: "abc123")
user2 = User.create(name: "user2", email: "user_two@example.com", password: "abc123")
user3 = User.create(name: "user3", email: "user_three@example.com", password: "abc123")
