# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Item.delete_all
Bid.delete_all

user1 = User.create(email: 'user1@example.com', password: 'secret99', password_confirmation: 'secret99')
user2 = User.create(email: 'user2@example.com', password: 'secret99', password_confirmation: 'secret99')
user3 = User.create(email: 'user3@example.com', password: 'secret99', password_confirmation: 'secret99')
user4 = User.create(email: 'user4@example.com', password: 'secret99', password_confirmation: 'secret99')


admin = User.create(email: 'admin@example.com', password: 'secret99', password_confirmation: 'secret99')
admin.add_role :admin

20.times do |index|
   item = Item.create(name: FFaker::Product.product_name, description: FFaker::Lorem.paragraphs.join("\n"))

   item.bids.create(user: user1)
   item.bids.create(user: user3)

  if index % 2 == 0
    item.bids.create(user: user4)
    item.bids.create(user: user2)
  end
end