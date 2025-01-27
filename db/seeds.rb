# Set locale for translations
I18n.locale = :en

# Helper method to seed categories and products
def seed_category(category_name, product_seeds)
  # Find or create the category
  category = Category.find_or_create_by(name: category_name)
  unless category
    puts "Error: '#{category_name}' category not found. Products not created."
    return
  end

  # Create or update products
  product_seeds.each do |attributes|
    product = Product.find_or_initialize_by(name: attributes[:name], category_id: category.id)
    product.update!(attributes)
  end

  # Remove products that are no longer in the seed file
  Product.where(category_id: category.id)
         .where.not(name: product_seeds.map { |p| p[:name] })
         .destroy_all
end

# Seed data for all categories
categories_with_products = {
  'Meat' => [
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
    { name: 'Rabbit Stew Meat', price: 10.99 },
    # Add other meat products here
  ],
  'Milk' => [
    { name: 'Whole Milk', price: 2.99 },
    { name: 'Skim Milk', price: 2.89 },
    { name: 'Whole Milk', price: 2.99 },
    { name: 'Skim Milk', price: 2.89 },
    { name: 'Almond Milk', price: 3.49 },
    { name: 'Oat Milk', price: 3.69 },
    { name: 'Soy Milk', price: 3.69 },
    # Add other milk products here
  ],
  'Eggs' => [
    { name: 'Organic Eggs (dozen)', price: 3.99 },
    { name: 'Cage-Free Eggs (dozen)', price: 4.29 },
    { name: 'Brown Eggs (dozen)', price: 3.79 },
    { name: 'White Eggs (dozen)', price: 2.99 },
    # Add other egg products here
  ],
  'Fruits' => [
    { name: 'Apple', price: 0.99 },
    { name: 'Banana', price: 0.59 },
    { name: 'Orange', price: 1.29 },
    { name: 'Strawberries', price: 3.99 },
    { name: 'Grapes', price: 2.99 },
    { name: 'Pineapple', price: 3.49 },
    # Add other fruit products here
  ],
  'Vegetables' => [
    { name: 'Carrot', price: 0.89 },
    { name: 'Broccoli', price: 1.99 },
    { name: 'Spinach', price: 2.49 },
    { name: 'Potato', price: 0.79 },
    { name: 'Tomato', price: 1.19 },
    { name: 'Lettuce', price: 0.80 },
    { name: 'Onion', price: 0.69 },
    # Add other vegetable products here
  ],
  'Cleaning' => [
    { name: 'Laundry Detergent', price: 8.99 },
    { name: 'Dish Soap', price: 2.99 },
    { name: 'All-Purpose Cleaner', price: 3.99 },
    { name: 'Glass Cleaner', price: 3.49 },
    { name: 'Toilet Cleaner', price: 4.99 },
    { name: 'Floor Cleaner', price: 5.49 },
    # Add other cleaning products here
  ],
  'Drinks' => [
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
    { name: 'Red Bull', price: 2.99 },
    # Add other drink products here
  ],
    'Alcoholic Drinks' => [
      { name: 'White Wine', price: 8.49 },
      { name: 'Porto Wine', price: 25.00 },
      { name: 'Champagne', price: 30.00 },
      { name: 'Tequila', price: 18.00 },
      { name: 'Aperol', price: 17.49 }
    ],
  'Bakery' => [
    { name: 'Sourdough Bread', price: 3.99 },
    { name: 'Whole Wheat Bread', price: 2.89 },
    { name: 'French Baguette', price: 2.49 },
    { name: 'Croissant', price: 1.30 },
    { name: 'Ciabatta', price: 3.49 },
    { name: 'Focaccia', price: 4.29 },
    { name: 'Rye Bread', price: 3.19 },
    { name: 'Gluten Free Bread', price: 5.49 },
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
    # Add other bakery products here
  ],
  'Car' => [
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
    { name: 'Oil Filter', price: 4.99 },
    # Add other car products here
  ],
  'Frozen' => [
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
    { name: 'Frozen Cookie Dough', price: 3.99 },
    # Add other frozen products here
  ],
  'Fish' => [
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
    { name: 'Snapper', price: 17.49 },
    # Add other fish products here
  ],
  'Cold Cuts and Cheeses' => [
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
    { name: 'Havarti', price: 5.99 },
  ],
  'Hygiene' => [
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
    { name: 'Eye Drops', price: 4.19 },
  ],
}

# Add admin user creation
admin_email = ENV.fetch("ADMIN_EMAIL")
admin_password = ENV.fetch("ADMIN_PASSWORD")

# Create or update the admin user
User.find_or_create_by!(email: admin_email) do |user|
  user.name = "Admin User"
  user.password = admin_password
  user.password_confirmation = admin_password
  user.admin = true
end

puts "Admin user '#{admin_email}' created or updated successfully."

# Iterate through categories and seed data
categories_with_products.each do |category_name, products|
  seed_category(category_name, products)
end
