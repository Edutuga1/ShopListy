# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

categories = ['Hygiene', 'Fruits', 'Meat', 'Fish']

categories.each do |category_name|
  category = Category.create(name: category_name)

  case category_name
  when 'Hygiene'
    ['Shower Gel', 'Shampoo', 'Toilet Paper'].each do |item_name|
      category.items.create(name: item_name)
    end
  when 'Fruits'
    ['Apple', 'Banana', 'Orange'].each do |item_name|
      category.items.create(name: item_name)
    end
  when 'Meat'
    ['Chicken', 'Beef', 'Pork'].each do |item_name|
      category.items.create(name: item_name)
    end
  when 'Fish'
    ['Salmon', 'Tuna', 'Cod'].each do |item_name|
      category.items.create(name: item_name)
    end
  end
end
