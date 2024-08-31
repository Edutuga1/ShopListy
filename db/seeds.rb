# db/seeds.rb

# Fetch the 'Meat' category
meat_category = Category.find_or_create_by(name: 'Meat')

# Create meat products if the 'Meat' category exists
if meat_category
  [
    { name: 'Beef Steak', price: 12.99 },
    { name: 'Chicken Breast', price: 8.99 },
    { name: 'Ground Beef', price: 8.99 },
    { name: 'Beef Ribs', price: 15.99 },
    { name: 'Beef Tenderloin', price: 24.99 },
    { name: 'Beef Brisket', price: 10.99 },
    { name: 'Pork Chops', price: 9.99 },
    { name: 'Pork Loin Roast', price: 14.99 },
    { name: 'Pork Belly', price: 11.99 },
    { name: 'Pork Sausage', price: 7.99 },
    { name: 'Ham Steak', price: 10.99 },
    { name: 'Chicken Thighs', price: 7.99 },
    { name: 'Chicken Wings', price: 6.99 },
    { name: 'Turkey Breast', price: 12.99 },
    { name: 'Duck Breast', price: 18.99 },
    { name: 'Lamb Chops', price: 18.99 },
    { name: 'Lamb Shoulder', price: 14.99 },
    { name: 'Ground Lamb', price: 11.99 },
    { name: 'Venison Steak', price: 20.99 },
    { name: 'Rabbit Stew Meat', price: 10.99 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: meat_category.id))
  end
else
  puts "Error: 'Meat' category not found. Meat products not created."
end

# Fetch the 'Milk' category
milk_category = Category.find_or_create_by(name: 'Milk')

# Create milk products if the 'Milk' category exists
if milk_category
  [
    { name: 'Whole Milk', price: 2.99 },
    { name: 'Skim Milk', price: 2.89 },
    { name: 'Almond Milk', price: 3.49 },
    { name: 'Oat Milk', price: 3.69 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: milk_category.id))
  end
else
  puts "Error: 'Milk' category not found. Milk products not created."
end

# Fetch the 'Eggs' category
eggs_category = Category.find_or_create_by(name: 'Eggs')

# Create egg products if the 'Eggs' category exists
if eggs_category
  [
    { name: 'Organic Eggs (dozen)', price: 3.99 },
    { name: 'Cage-Free Eggs (dozen)', price: 4.29 },
    { name: 'Brown Eggs (dozen)', price: 3.79 },
    { name: 'White Eggs (dozen)', price: 2.99 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: eggs_category.id))
  end
else
  puts "Error: 'Eggs' category not found. Egg products not created."
end

# Fetch the 'Fruits' category
fruits_category = Category.find_or_create_by(name: 'Fruits')

# Create fruit products if the 'Fruits' category exists
if fruits_category
  [
    { name: 'Apple', price: 0.99 },
    { name: 'Banana', price: 0.59 },
    { name: 'Orange', price: 1.29 },
    { name: 'Strawberries', price: 3.99 },
    { name: 'Grapes', price: 2.99 },
    { name: 'Pineapple', price: 3.49 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: fruits_category.id))
  end
else
  puts "Error: 'Fruits' category not found. Fruit products not created."
end

# Fetch the 'Vegetables' category
vegetables_category = Category.find_or_create_by(name: 'Vegetables')

# Create vegetable products if the 'Vegetables' category exists
if vegetables_category
  [
    { name: 'Carrot', price: 0.89 },
    { name: 'Broccoli', price: 1.99 },
    { name: 'Spinach', price: 2.49 },
    { name: 'Potato', price: 0.79 },
    { name: 'Tomato', price: 1.19 },
    { name: 'Lettuce', price: 0.80 },
    { name: 'Onion', price: 0.69 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: vegetables_category.id))
  end
else
  puts "Error: 'Vegetables' category not found. Vegetable products not created."
end

# Fetch the 'Cleaning' category
cleaning_category = Category.find_or_create_by(name: 'Cleaning')

# Create cleaning products if the 'Cleaning' category exists
if cleaning_category
  [
    { name: 'Laundry Detergent', price: 8.99 },
    { name: 'Dish Soap', price: 2.99 },
    { name: 'All-Purpose Cleaner', price: 3.99 },
    { name: 'Glass Cleaner', price: 3.49 },
    { name: 'Toilet Cleaner', price: 4.99 },
    { name: 'Floor Cleaner', price: 5.49 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: cleaning_category.id))
  end
else
  puts "Error: 'Cleaning' category not found. Cleaning products not created."
end

# Fetch the 'Drinks' category
drinks_category = Category.find_or_create_by(name: 'Drinks')

# Create drink products if the 'Drinks' category exists
if drinks_category
  [
    { name: 'Coca-Cola', price: 1.49 },
    { name: 'Pepsi', price: 1.39 },
    { name: 'Orange Juice', price: 2.99 },
    { name: 'Apple Juice', price: 2.89 },
    { name: 'Lemonade', price: 3.49 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: drinks_category.id))
  end
else
  puts "Error: 'Drinks' category not found. Drink products not created."
end

# Fetch the 'Bakery' category
bakery_category = Category.find_or_create_by(name: 'Bakery')

# Create bakery products if the 'Bakery' category exists
if bakery_category
  [
    { name: 'Bread', price: 2.49 },
    { name: 'Croissant', price: 1.99 },
    { name: 'Muffin', price: 2.29 },
    { name: 'Bagel', price: 1.79 },
    { name: 'Donut', price: 1.49 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: bakery_category.id))
  end
else
  puts "Error: 'Bakery' category not found. Bakery products not created."
end

# Fetch the 'Car' category
car_category = Category.find_or_create_by(name: 'Car')

# Create car products if the 'Car' category exists
if car_category
  [
    { name: 'Engine Oil', price: 24.99 },
    { name: 'Car Wax', price: 12.99 },
    { name: 'Windshield Wiper Fluid', price: 2.99 },
    { name: 'Brake Pads', price: 49.99 },
    { name: 'Air Filter', price: 15.99 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: car_category.id))
  end
else
  puts "Error: 'Car' category not found. Car products not created."
end

# Fetch the 'Frozen' category
frozen_category = Category.find_or_create_by(name: 'Frozen')

# Create frozen products if the 'Frozen' category exists
if frozen_category
  [
    { name: 'Frozen Pizza', price: 6.99 },
    { name: 'Ice Cream', price: 4.49 },
    { name: 'Frozen Vegetables', price: 3.29 },
    { name: 'Frozen Berries', price: 5.99 },
    { name: 'Frozen Meals', price: 7.49 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: frozen_category.id))
  end
else
  puts "Error: 'Frozen' category not found. Frozen products not created."
end

# Fetch the 'Fish' category
fish_category = Category.find_or_create_by(name: 'Fish')

# Create fish products if the 'Fish' category exists
if fish_category
  [
    { name: 'Salmon Fillet', price: 14.99 },
    { name: 'Tuna Steak', price: 16.99 },
    { name: 'Cod', price: 11.49 },
    { name: 'Tilapia', price: 9.99 },
    { name: 'Mahi Mahi', price: 18.49 },
    { name: 'Shrimp', price: 12.99 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: fish_category.id))
  end
else
  puts "Error: 'Fish' category not found. Fish products not created."
end

# Fetch the 'Cold Cuts and Cheeses' category
cold_cuts_and_cheeses_category = Category.find_or_create_by(name: 'Cold_cuts_and_cheeses')

# Create cold cuts and cheeses products if the 'Cold Cuts and Cheeses' category exists
if cold_cuts_and_cheeses_category
  [
    { name: 'Prosciutto', price: 12.99 },
    { name: 'Salami', price: 10.49 },
    { name: 'Pepperoni', price: 8.99 },
    { name: 'Gouda', price: 5.99 },
    { name: 'Cheddar', price: 4.99 },
    { name: 'Brie', price: 6.49 },
    { name: 'Parmesan', price: 7.99 },
    { name: 'Swiss Cheese', price: 5.49 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: cold_cuts_and_cheeses_category.id))
  end
else
  puts "Error: 'Cold Cuts and Cheeses' category not found. Cold cuts and cheeses products not created."
end

hygiene_category = Category.find_or_create_by(name: 'Hygiene')

# Create hygiene products if the 'Hygiene' category exists
if hygiene_category
  [
    { name: 'Toothpaste', price: 2.99 },
    { name: 'Toothbrush', price: 1.49 },
    { name: 'Shampoo', price: 5.49 },
    { name: 'Conditioner', price: 5.49 },
    { name: 'Body Wash', price: 4.99 },
    { name: 'Bar Soap', price: 2.29 },
    { name: 'Deodorant', price: 3.99 },
    { name: 'Hand Sanitizer', price: 3.49 },
    { name: 'Facial Cleanser', price: 6.99 },
    { name: 'Moisturizer', price: 7.99 },
    { name: 'Shaving Cream', price: 4.29 },
    { name: 'Razor', price: 5.99 },
    { name: 'Cotton Swabs', price: 2.49 },
    { name: 'Cotton Balls', price: 1.99 },
    { name: 'Face Mask', price: 3.99 },
    { name: 'Hand Cream', price: 4.49 },
    { name: 'Body Lotion', price: 6.29 },
    { name: 'Antiseptic', price: 4.99 },
    { name: 'Hair Gel', price: 3.99 },
    { name: 'Hair Spray', price: 5.49 },
    { name: 'Nail Clippers', price: 2.99 },
    { name: 'Nail File', price: 1.49 },
    { name: 'Lip Balm', price: 2.19 },
    { name: 'Foot Cream', price: 5.99 },
    { name: 'Sunblock', price: 8.49 },
    { name: 'Aftershave', price: 6.99 },
    { name: 'Ear Drops', price: 3.49 },
    { name: 'Cough Drops', price: 2.79 },
    { name: 'Eye Drops', price: 4.19 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: hygiene_category.id))
  end
else
  puts "Error: 'Hygiene' category not found. Hygiene products not created."
end
