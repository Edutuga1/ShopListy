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
  # Non-alcoholic drinks
  [
    { name: 'Coca-Cola', price: 1.49 },
    { name: 'Water', price: 0.99 },
    { name: 'Sparkling Water', price: 1.19 },
    { name: 'Gatorade', price: 1.79 },
    { name: 'Powerade', price: 1.69 },
    { name: 'Pepsi', price: 1.39 },
    { name: 'Ice Tea', price: 1.69 },
    { name: 'Guaraná', price: 1.59 },
    { name: '7-Up', price: 1.29 },
    { name: 'Dr.Pepper', price: 1.49 },
    { name: 'Fanta Orange', price: 1.39 },
    { name: 'Fanta Pineapple', price: 1.39 },
    { name: 'Fanta Strawberry', price: 1.39 },
    { name: 'Fanta Grape', price: 1.39 },
    { name: 'Orange Juice', price: 2.99 },
    { name: 'Apple Juice', price: 2.89 },
    { name: 'Pineapple Juice', price: 2.49 },
    { name: 'Lemonade', price: 3.49 },
    { name: 'Tonic Water', price: 1.49 },
    { name: 'Ginger Ale', price: 1.29 },
    { name: 'Soda', price: 1.19 },
    { name: 'Monster Energy Drink', price: 2.49 },
    { name: 'Red Bull', price: 2.99 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: drinks_category.id))
  end

  # Alcoholic drinks
  [
    { name: 'White Wine', price: 8.49 },
    { name: 'Red Wine', price: 9.89 },
    { name: 'Rose Wine', price: 7.39 },
    { name: 'Whiskey', price: 20.00 },
    { name: 'Gin', price: 15.00 },
    { name: 'Rum', price: 12.00 },
    { name: 'Vodka', price: 10.00 },
    { name: 'Beer', price: 1.99 },
    { name: 'Cider', price: 2.49 },
    { name: 'Porto Wine', price: 25.00 },
    { name: 'Champagne', price: 30.00 },
    { name: 'Tequila', price: 18.00 },
    { name: 'Aperol', price: 17.49 }
  ].each do |product_attributes|
    Product.find_or_create_by!(product_attributes.merge(category_id: drinks_category.id))
  end
else
  puts "Error: 'Drinks' category not found. Drink products not created."
end

# Fetch the 'Bakery' category
bakery_category = Category.find_or_create_by(name: 'Bakery')

if bakery_category
  bakery_seeds = [
    { name: 'Sourdough Bread', price: 3.99 },
    { name: 'Whole Wheat Bread', price: 2.89 },
    { name: 'French Baguette', price: 2.49 },
    { name: 'Croissant', price: 1.30 },
    { name: 'Ciabatta', price: 3.49 },
    { name: 'Focaccia', price: 4.29 },
    { name: 'Rye Bread', price: 3.19 },
    { name: 'Gluten-Free Bread', price: 5.49 },
    { name: 'Banana Bread', price: 4.99 },
    { name: 'Blueberry Muffin', price: 2.49 },
    { name: 'Chocolate Chip Muffin', price: 2.79 },
    { name: 'Chocolate Croissant', price: 2.99 },
    { name: 'Cinnamon Roll', price: 3.19 },
    { name: 'Cheese Danish', price: 3.29 },
    { name: 'Apple Turnover', price: 2.99 },
    { name: 'Strawberry Tart', price: 3.99 },
    { name: 'Lemon Pound Cake', price: 4.79 },
    { name: 'Carrot Cake', price: 5.49 },
    { name: 'Chocolate Cake Slice', price: 3.99 },
    { name: 'Vanilla Cupcake', price: 2.49 },
    { name: 'Red Velvet Cupcake', price: 2.99 },
    { name: 'Eclair', price: 3.49 },
    { name: 'Cream Puff', price: 2.79 },
    { name: 'Pecan Pie Slice', price: 4.29 },
    { name: 'Pumpkin Pie Slice', price: 3.99 },
    { name: 'Butter Biscuit', price: 1.29 },
    { name: 'Shortbread Cookie', price: 0.99 },
    { name: 'Macarons', price: 7.99 },
    { name: 'Brioche Loaf', price: 5.49 },
    { name: 'Pita Bread', price: 3.19 },
    { name: 'English Muffin', price: 2.89 },
    { name: 'Pretzel', price: 2.49 },
    { name: 'Garlic Knots', price: 3.29 },
    { name: 'Cornbread', price: 4.19 },
    { name: 'Dinner Rolls', price: 5.99 },
    { name: 'Hot Dog Buns', price: 3.09 },
    { name: 'Hamburger Buns', price: 3.19 },
    { name: 'Pain au Chocolat', price: 2.89 },
    { name: 'Oreo', price: 2.50 },
    { name: 'Bollycao', price: 1.30 },
    { name: 'Belgas', price: 1.99 },
    { name: 'Filipinos', price: 1.50 },
  ]
  # Update or create bakery products
  bakery_seeds.each do |attributes|
    product = Product.find_or_initialize_by(name: attributes[:name], category_id: bakery_category.id)
    product.update!(attributes)
  end
  # Remove products that are no longer in the seed file
  Product.where(category_id: bakery_category.id)
         .where.not(name: bakery_seeds.map { |p| p[:name] })
         .destroy_all
else
  puts "Error: 'Bakery' category not found. Bakery products not created."
end

# Fetch the 'Car' category
car_category = Category.find_or_create_by(name: 'Car')

# Create car products if the 'Car' category exists
if car_category
  car_seeds = [
    { name: 'Engine Oil', price: 24.99 },
    { name: 'Windshield Wiper Blades', price: 19.99 },
    { name: 'Brake Oil', price: 99.99 },
    { name: 'Coolant', price: 25.99 },
    { name: 'Car Wax', price: 12.99 },
    { name: 'Windshield Wiper Fluid', price: 2.99 },
    { name: 'Brake Pads', price: 49.99 },
    { name: 'Air Filter', price: 15.99 },
    { name: 'Car Battery', price: 99.99 },
    { name: 'Tire Pressure Gauge', price: 9.99 },
    { name: 'Car Wash Soap', price: 7.99 },
    { name: 'Car Wax', price: 12.99 },
    { name: 'Car Polish', price: 14.99 },
    { name: 'Car Sponge', price: 2.99 },
    { name: 'Brake Disks', price: 25.99 },
    { name: 'Car Wax Buffer', price: 19.99 },
    { name: 'Car Wax Pad', price: 4.99 },
    { name: 'Car Wax Spray', price: 8.99 },
    { name: 'Air Filter', price: 4.99 },
    { name: 'Cabin Filter', price: 4.99 },
    { name: 'Oil Filter', price: 4.99 }
  ]
   # Update or create bakery products
    car_seeds.each do |attributes|
    product = Product.find_or_initialize_by(name: attributes[:name], category_id: car_category.id)
    product.update!(attributes)
  end
  # Remove products that are no longer in the seed file
  Product.where(category_id: car_category.id)
         .where.not(name: car_seeds.map { |p| p[:name] })
         .destroy_all
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
    { name: 'Frozen Meals', price: 7.49 },
    { name: 'Frozen Waffles', price: 3.79 },
    { name: 'Frozen Pancakes', price: 4.29 },
    { name: 'Frozen French Fries', price: 2.99 },
    { name: 'Frozen Chicken Nuggets', price: 6.49 },
    { name: 'Frozen Fish Sticks', price: 5.99 },
    { name: 'Frozen Meatballs', price: 7.99 },
    { name: 'Frozen Pizza Rolls', price: 4.99 },
    { name: 'Frozen Lasagna', price: 8.49 },
    { name: 'Frozen Garlic Bread', price: 3.49 },
    { name: 'Frozen Shrimp', price: 12.99 },
    { name: 'Frozen Turkey Burgers', price: 8.29 },
    { name: 'Frozen Mixed Vegetables', price: 2.99 },
    { name: 'Frozen Peas', price: 2.49 },
    { name: 'Frozen Spinach', price: 2.79 },
    { name: 'Frozen Blueberries', price: 4.99 },
    { name: 'Frozen Strawberries', price: 5.49 },
    { name: 'Frozen Dumplings', price: 7.29 },
    { name: 'Frozen Spring Rolls', price: 5.79 },
    { name: 'Frozen Empanadas', price: 6.99 },
    { name: 'Frozen Cookie Dough', price: 3.99 }
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
    { name: 'Shrimp', price: 12.99 },
    { name: 'Halibut', price: 22.49 },
    { name: 'Sea Bass', price: 24.99 },
    { name: 'Sardines', price: 7.99 },
    { name: 'Rainbow Trout', price: 13.49 },
    { name: 'Catfish Fillet', price: 10.99 },
    { name: 'King Crab Legs', price: 34.99 },
    { name: 'Lobster Tail', price: 29.99 },
    { name: 'Clams', price: 8.99 },
    { name: 'Mussels', price: 9.49 },
    { name: 'Oysters', price: 14.99 },
    { name: 'Scallops', price: 19.99 },
    { name: 'Swordfish Steak', price: 21.99 },
    { name: 'Haddock', price: 12.99 },
    { name: 'Snapper', price: 17.49 }
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
    { name: 'Swiss Cheese', price: 5.49 },
    { name: 'Mozzarella', price: 4.99 },
    { name: 'Feta', price: 6.99 },
    { name: 'Goat Cheese', price: 7.49 },
    { name: 'Blue Cheese', price: 8.49 },
    { name: 'Havarti', price: 5.99 }
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
