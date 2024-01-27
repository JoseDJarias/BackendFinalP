# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Create example categories
# Category.create(name: 'Electronics')
# Category.create(name: 'Clothing')
# Add more categories as needed

# Create example products
6.times do
    Product.create(
      id:6,
      name:'Kaka',
      description: 'Faker::Lorem.sentence',
      unitary_price: 1200,
      purchase_price: 1000,
      stock: 1,
      available: true,
      category_id:1
    )
  end
