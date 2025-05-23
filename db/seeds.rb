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
    { name: 'Beef Picanha', price: 19.99 },
    { name: 'Beef Hamburguer', price: 16.99 },
    { name: 'Beef Sausage', price: 14.99 },
    { name: 'Turkey Steaks', price: 15.99 },
  ],
  'Milk' => [
    { name: 'Whole Milk', price: 2.99 },
    { name: 'Skim Milk', price: 2.89 },
    { name: 'Skim Milk', price: 2.89 },
    { name: 'Almond Milk', price: 3.49 },
    { name: 'Oat Milk', price: 3.69 },
    { name: 'Soy Milk', price: 3.69 },
    { name: 'Coconut Milk', price: 3.29 },
    { name: 'Chocolate Milk', price: 3.49 },
    { name: 'Lactose-Free Milk', price: 3.49 },
    { name: 'Buttermilk', price: 2.99 },
    { name: 'Liquid Yogurt (Flavor)', price: 1.99 },
    { name: 'Liquid Yogurt (Natural)', price: 1.99 },
    { name: 'Yogurt (Natural)', price: 3.99 },
    { name: 'Yogurt (Flavor)', price: 3.99 },
    { name: 'Greek Yogurt', price: 4.99 },
    { name: 'Sugar Free Yogurt', price: 3.99 },
    { name: 'Sugar Free Liquid Yogurt', price: 3.99 },
  ],
  'Eggs' => [
    { name: 'Organic Eggs (dozen)', price: 3.99 },
    { name: 'Cage-Free Eggs (dozen)', price: 4.29 },
    { name: 'Brown Eggs (dozen)', price: 3.79 },
    { name: 'White Eggs (dozen)', price: 2.99 },
    { name: 'Pasteurized Egg White', price: 5.99 },
    { name: 'Pasteurized Egg Yolk', price: 5.99 },
    { name: 'Quail Eggs', price: 5.99 },
  ],
  'Sugar & Desserts' => [
    { name: 'Sugar', price: 1.99 },
    { name: 'Brown Sugar', price: 2.49 },
    { name: 'Tiramisu', price: 4.99 },
    { name: 'Chocolate Cake', price: 5.49 },
    { name: 'Apple Pie', price: 4.99 },
    { name: 'Cheesecake', price: 5.99 },
    { name: 'Flour', price: 3.99 },
    { name: 'Cake Mix', price: 2.99 },
    { name: 'Brownie Mix', price: 2.99 },
    { name: 'Pudding Mix', price: 1.99 },
    { name: 'Gelatin', price: 1.49 },

  ],
  'Jams, Creams & Honey' => [
    { name: 'Strawberry Jam', price: 2.99 },
    { name: 'Raspberry Jam', price: 3.49 },
    { name: 'Blueberry Jam', price: 3.79 },
    { name: 'Honey', price: 5.99 },
    { name: 'Peanut Butter', price: 2.49 },
    { name: 'Chocolate Spread', price: 3.69 },
    { name: 'Nutella', price: 4.99 },
    { name: 'Maple Syrup', price: 6.99 },
  ],
  'Preserves' => [
    { name: 'Canned Tuna', price: 4.99 },
    { name: 'Canned Salmon', price: 6.99 },
    { name: 'Canned Sardines', price: 3.99 },
    { name: 'Canned Mackerel', price: 4.49 },
    { name: 'Canned Anchovies', price: 5.49 },
    { name: 'Canned Clams', price: 4.99 },
    { name: 'Canned Crab', price: 7.99 },
    { name: 'Canned Shrimp', price: 6.49 },
    { name: 'Canned Corn', price: 1.49 },
    { name: 'Canned Peas', price: 1.49 },
    { name: 'Canned Green Beans', price: 1.49 },
    { name: 'Canned Mushrooms', price: 2.49 },
    { name: 'Canned Tomatoes', price: 1.99 },
    { name: 'Canned Tomato Sauce', price: 2.49 },
    { name: 'Canned Tomato Paste', price: 1.99 },
    { name: 'Canned Chili', price: 3.49 },
    { name: 'Canned Fruit', price: 2.49 },
  ],
  'Sauces, Seasonings & Salt' => [
    { name: 'Ketchup', price: 2.49 },
    { name: 'Mustard', price: 1.99 },
    { name: 'Tomato Pulp', price: 3.49 },
    { name: 'Heavy Cream', price: 3.49 },
    { name: 'Mayonnaise', price: 3.49 },
    { name: 'Soy Sauce', price: 2.99 },
    { name: 'Hot Sauce', price: 3.49 },
    { name: 'Barbecue Sauce', price: 3.99 },
    { name: 'Teriyaki Sauce', price: 3.99 },
    { name: 'Worcestershire Sauce', price: 3.49 },
    { name: 'Bolognese Pasta Sauce', price: 3.69 },
    { name: 'Pesto Sauce', price: 3.69 },
    { name: 'Salt', price: 3.99 },
    { name: 'Sea Salt', price: 4.49 },
    { name: 'Black Pepper', price: 2.99 },
    { name: 'Garlic Powder', price: 2.49 },
    { name: 'Onion Powder', price: 2.49 },
    { name: 'Paprika', price: 2.99 },
    { name: 'Curry', price: 1.49 },
    { name: 'Cayenne Pepper', price: 2.99 },
    { name: 'Cumin', price: 2.99 },
    { name: 'Oregano', price: 2.49 },
    { name: 'Basil', price: 2.49 },
    { name: 'Bay Leaf', price: 2.49 },
    { name: 'Thyme', price: 2.49 },
    { name: 'Rosemary', price: 2.49 },
    { name: 'Parsley', price: 2.49 },
    { name: 'Dill', price: 2.49 },
    { name: 'Cinnamon', price: 2.49 },
    { name: 'Ginger', price: 2.49 },
    { name: 'Vanilla Extract', price: 4.99 },
    { name: 'Almond Extract', price: 4.99 },
],
  'Olive Oil & Vinegar' => [
    { name: 'Extra Virgin Olive Oil', price: 12.99 },
    { name: 'Virgin Olive Oil', price: 4.85 },
    { name: 'Olive Oil', price: 3.99 },
    { name: 'Pure Sunflower Oil', price: 1.99 },
    { name: 'Cooking Oil', price: 1.00 },
    { name: 'Balsamic Vinegar', price: 8.99 },
    { name: 'Red Wine Vinegar', price: 5.49 },
    { name: 'White Wine Vinegar', price: 5.99 },
    { name: 'Apple Cider Vinegar', price: 4.99 },
  ],
  'Cereals & Bars' => [
    { name: 'Granola Bar', price: 2.99 },
    { name: 'Protein Bar', price: 3.49 },
    { name: 'Corn Flakes', price: 4.99 },
    { name: 'Oatmeal', price: 3.79 },
    { name: 'Cheerios', price: 4.49 },
    { name: 'Rice Krispies', price: 4.49 },
    { name: 'Frosted Flakes', price: 4.99 },
  ],
  'Coffee, Tea & Instant Drinks' => [
    { name: 'Ground Coffee', price: 3.99 },
    { name: 'Instant Coffee', price: 4.49 },
    { name: 'Coffee Pods', price: 7.99 },
    { name: 'Green Tea', price: 2.99 },
    { name: 'Black Tea', price: 2.99 },
    { name: 'Herbal Tea', price: 3.49 },
    { name: 'Chai Tea', price: 3.49 },
  ],
  'Fruits' => [
    { name: 'Apple', price: 0.99 },
    { name: 'Banana', price: 0.59 },
    { name: 'Orange', price: 1.29 },
    { name: 'Strawberries', price: 3.99 },
    { name: 'Grapes', price: 2.99 },
    { name: 'Pineapple', price: 3.49 },
    { name: 'Watermelon', price: 4.99 },
    { name: 'Cantaloupe', price: 2.99 },
    { name: 'Kiwi', price: 0.79 },
    { name: 'Mango', price: 1.49 },
    { name: 'Peach', price: 1.19 },
    { name: 'Pear', price: 1.29 },
    { name: 'Plum', price: 0.99 },
    { name: 'Cherry', price: 3.99 },
    { name: 'Blueberry', price: 2.99 },
    { name: 'Raspberry', price: 3.49 },
    { name: 'Blackberry', price: 3.49 },
    { name: 'Lemon', price: 0.79 },
    { name: 'Lime', price: 0.79 },
    { name: 'Coconut', price: 2.99 },
    { name: 'Avocado', price: 1.99 },
    { name: 'Pomegranate', price: 2.99 },
    { name: 'Passion Fruit', price: 1.99 },
    { name: 'Dragon Fruit', price: 3.99 },
    { name: 'Guava', price: 1.49 },
    { name: 'Papaya', price: 2.49 },
    { name: 'Cranberry', price: 2.99 },
    { name: 'Clementine', price: 1.29 },
    { name: 'Tangerine', price: 1.19 },
    { name: 'Nectarine', price: 1.29 },
    { name: 'Apricot', price: 1.19 },
    { name: 'Fig', price: 1.49 },
    { name: 'Date', price: 1.29 },
    { name: 'Lychee', price: 2.99 },
    { name: 'Mangosteen', price: 3.99 },
    { name: 'Starfruit', price: 2.49 },
    { name: 'Kumquat', price: 1.29 },
    { name: 'Persimmon', price: 1.99 },
  ],
  'Vegetables' => [
    { name: 'Carrot', price: 0.89 },
    { name: 'Broccoli', price: 1.99 },
    { name: 'Spinach', price: 2.49 },
    { name: 'Potato', price: 0.79 },
    { name: 'Tomato', price: 1.19 },
    { name: 'Lettuce', price: 0.80 },
    { name: 'Onion', price: 0.69 },
    { name: 'Garlic', price: 0.50 },
    { name: 'Bell Pepper', price: 1.29 },
    { name: 'Cucumber', price: 0.79 },
    { name: 'Zucchini', price: 1.19 },
    { name: 'Mushroom', price: 2.99 },
    { name: 'Asparagus', price: 3.49 },
    { name: 'Cauliflower', price: 2.99 },
    { name: 'Green Beans', price: 1.99 },
    { name: 'Peas', price: 1.49 },
    { name: 'Corn', price: 0.99 },
    { name: 'Brussels Sprouts', price: 2.49 },
    { name: 'Artichoke', price: 3.99 },
    { name: 'Eggplant', price: 1.49 },
    { name: 'Celery', price: 1.29 },
    { name: 'Cabbage', price: 0.99 },
    { name: 'Pumpkin', price: 2.99 },
    { name: 'Sweet Potato', price: 1.29 },
    { name: 'Beet', price: 1.19 },
    { name: 'Radish', price: 0.89 },
    { name: 'Turnip', price: 0.99 },
    { name: 'Kale', price: 2.49 },
    { name: 'Arugula', price: 2.99 },
    { name: 'Watercress', price: 2.49 },
    { name: 'Romaine Lettuce', price: 1.29 },
    { name: 'Iceberg Lettuce', price: 0.99 },
    { name: 'Radicchio', price: 1.99 },
  ],
  'Cleaning' => [
    { name: 'Laundry Detergent', price: 8.99 },
    { name: 'Dish Soap', price: 2.99 },
    { name: 'All-Purpose Cleaner', price: 3.99 },
    { name: 'Glass Cleaner', price: 3.49 },
    { name: 'Toilet Cleaner', price: 4.99 },
    { name: 'Floor Cleaner', price: 5.49 },
    { name: 'Bleach', price: 2.99 },
    { name: 'Disinfectant Wipes', price: 3.99 },
    { name: 'Sponges', price: 1.99 },
    { name: 'Scrub Brush', price: 2.99 },
    { name: 'Mop', price: 9.99 },
    { name: 'Broom', price: 7.99 },
    { name: 'Dustpan', price: 3.99 },
    { name: 'Trash Bags', price: 4.99 },
    { name: 'Paper Towels', price: 2.99 },
    { name: 'Toilet Paper', price: 3.99 },
    { name: 'Dishwasher Detergent', price: 5.99 },
    { name: 'Fabric Softener', price: 6.99 },
    { name: 'Stain Remover', price: 4.99 },
    { name: 'Carpet Cleaner', price: 7.99 },
    { name: 'Oven Cleaner', price: 5.99 },
    { name: 'Drain Cleaner', price: 4.99 },
    { name: 'Air Freshener', price: 2.99 },
    { name: 'Furniture Polish', price: 3.99 },
    { name: 'Shoe Polish', price: 2.99 },
    { name: 'Silver Polish', price: 4.99 },
    { name: 'Wood Polish', price: 3.99 },
    { name: 'Stainless Steel Cleaner', price: 3.99 },
    { name: 'Granite Cleaner', price: 4.99 },
    { name: 'Marble Cleaner', price: 5.99 },
    { name: 'Tile Cleaner', price: 4.99 },
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
    { name: 'White Wine', price: 8.49 },
    { name: 'Red Wine', price: 10.99 },
    { name: 'Porto Wine', price: 25.00 },
    { name: 'Champagne', price: 30.00 },
    { name: 'Tequila', price: 18.00 },
    { name: 'Aperol', price: 17.49 },
    { name: 'Vodka', price: 15.00 },
    { name: 'Whiskey', price: 20.00 },
    { name: 'Rum', price: 18.00 },
    { name: 'Gin', price: 17.00 },
    { name: 'Beer', price: 1.50 },
    { name: 'Cider', price: 3.00 },
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
    { name: 'Fuel Filter', price: 4.99 },
    { name: 'Car Jack', price: 29.99 },
    { name: 'Car Jack Stand', price: 19.99 },
    { name: 'Car Battery', price: 99.99 },
    { name: 'Car Battery Charger', price: 49.99 },
    { name: 'Car Battery Jumper', price: 39.99 },
    { name: 'Car Battery Tester', price: 19.99 },
    { name: 'Car Battery Terminal Cleaner', price: 9.99 },
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
  ],
  'Cold Cuts and Cheeses' => [
    { name: 'Prosciutto', price: 9.99 },
    { name: 'Salami', price: 7.49 },
    { name: 'Pepperoni', price: 6.99 },
    { name: 'Bacon', price: 2.50 },
    { name: 'Smoked Bacon Strips', price: 1.99 },
    { name: 'Turkey Breast', price: 1.99 },
    { name: 'Ham', price: 2.99 },
    { name: 'Smoked Salmon', price: 2.99 },
    { name: 'Chorizo', price: 3.99 },
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
    { name: 'Sliced Flamengo Cheese', price: 4.99 },
    { name: 'Lactose-Free Flamengo Cheese Sliced', price: 4.99 },
    { name: 'Sliced Gouda Cheese', price: 4.99 },
    { name: 'Sliced Cheddar Cheese', price: 4.99 },
    { name: 'Sliced Swiss Cheese', price: 4.99 },
    { name: 'Sliced Mozzarella Cheese', price: 4.99 },
    { name: 'Low-fat Cottage Cheese', price: 4.99 },
    { name: 'Cream Cheese', price: 3.99 },
    { name: 'Sliced Cured Cheese', price: 4.99 },
    { name: 'Brie Cheese', price: 4.99 },
    { name: 'Camembert Cheese', price: 4.99 },
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
  'Pasta' => [
    { name: 'Spaghetti', price: 1.29 },
    { name: 'Fettuccine', price: 1.49 },
    { name: 'Penne', price: 1.19 },
    { name: 'Rigatoni', price: 1.39 },
    { name: 'Linguine', price: 1.29 },
    { name: 'Angel Hair', price: 1.49 },
    { name: 'Farfalle', price: 1.19 },
    { name: 'Orzo', price: 1.39 },
    { name: 'Couscous', price: 1.29 },
    { name: 'Tagliatelle', price: 1.49 },
    { name: 'Macaroni', price: 1.19 },
    { name: 'Fusilli', price: 1.39 },
    { name: 'Lasagna', price: 1.29 },
    { name: 'Gnocchi', price: 1.49 },
  ],
  'Snacks' => [
    { name: 'Oreo', price: 2.50 },
    { name: 'Bollycao', price: 1.30 },
    { name: 'Belgas', price: 1.99 },
    { name: 'Filipinos', price: 1.50 },
    { name: 'Potato Chips', price: 2.49 },
    { name: 'Popcorn', price: 1.49 },
    { name: 'Chocolate', price: 1.50 },
    { name: 'Doritos', price: 2.99 },
    { name: 'Cheetos', price: 2.49 },
    { name: 'Cookies', price: 2.99 },
    { name: 'Chocolate Cookies', price: 2.99 },
    { name: 'Crackers', price: 1.99 },
    { name: 'Fiber and Sugar Free Cookies', price: 2.99 },
    { name: 'Assorted Cookies', price: 1.99 },
  ],
  'Pharmacy' => [
    { name: 'Aspirin', price: 4.99 },
    { name: 'Ibuprofen', price: 5.49 },
    { name: 'Acetaminophen', price: 4.99 },
    { name: 'Antacid', price: 3.99 },
    { name: 'Laxative', price: 6.49 },
    { name: 'Antihistamine', price: 7.49 },
    { name: 'Cough Syrup', price: 8.49 },
    { name: 'Throat Lozenges', price: 2.99 },
    { name: 'Vitamin C', price: 9.99 },
    { name: 'Vitamin D', price: 10.99 },
    { name: 'Vitamin B12', price: 11.99 },
    { name: 'Calcium Supplement', price: 12.99 },
    { name: 'Iron Supplement', price: 13.99 },
    { name: 'Magnesium Supplement', price: 14.99 },
    { name: 'Zinc Supplement', price: 15.99 },
    { name: 'Fish Oil', price: 16.99 },
    { name: 'Probiotic', price: 17.99 },
    { name: 'Melatonin', price: 18.99 },
    { name: 'Sleep Aid', price: 19.99 },
    { name: 'First Aid Kit', price: 19.99 },
    { name: 'Thermometer', price: 9.99 },
    { name: 'Band-Aids', price: 3.99 },
    { name: 'Cotton Balls', price: 1.99 },
    { name: 'Alcohol Wipes', price: 2.99 },
    { name: 'Hand Sanitizer', price: 3.49 },
    { name: 'Face Mask', price: 3.99 },
    { name: 'Gloves', price: 4.49 },
    { name: 'Contact Solution', price: 5.49 },
    { name: 'Contact Lens Case', price: 1.49 },
    { name: 'Contact Lenses', price: 49.99 },
    { name: 'Antiseptic', price: 4.99 },
  ],
  'Pets' => [
    { name: 'Dog Food', price: 9.99 },
    { name: 'Cat Food', price: 8.99 },
    { name: 'Dog Treats', price: 4.99 },
    { name: 'Cat Treats', price: 3.99 },
    { name: 'Dog Toys', price: 7.99 },
    { name: 'Cat Toys', price: 6.99 },
    { name: 'Dog Leash', price: 12.99 },
    { name: 'Cat Collar', price: 8.99 },
    { name: 'Dog Bed', price: 19.99 },
    { name: 'Cat Bed', price: 17.99 },
    { name: 'Dog Shampoo', price: 5.99 },
    { name: 'Cat Shampoo', price: 4.99 },
    { name: 'Pet Brush', price: 3.99 },
    { name: 'Pet Toothbrush', price: 2.99 },
    { name: 'Pet Toothpaste', price: 4.99 },
    { name: 'Dog Poop Bags', price: 1.99 },
    { name: 'Cat Litter', price: 6.99 },
    { name: 'Dog Collar', price: 9.99 },
    { name: 'Dog Bowl', price: 3.99 },
    { name: 'Cat Bowl', price: 2.99 },
    { name: 'Bird Seed', price: 19.99 },
    { name: 'Cat Litter Box', price: 4.99 },
  ],
  'Baby' => [
    { name: 'Diapers', price: 9.99 },
    { name: 'Baby Wipes', price: 4.99 },
    { name: 'Baby Formula', price: 12.99 },
    { name: 'Baby Food', price: 3.99 },
    { name: 'Baby Shampoo', price: 5.99 },
    { name: 'Baby Lotion', price: 4.99 },
    { name: 'Baby Powder', price: 3.99 },
    { name: 'Baby Oil', price: 2.99 },
    { name: 'Baby Bath Tub', price: 19.99 },
    { name: 'Baby Towels', price: 9.99 },
    { name: 'Baby Clothes', price: 12.99 },
    { name: 'Baby Shoes', price: 8.99 },
    { name: 'Baby Socks', price: 4.99 },
    { name: 'Baby Hat', price: 3.99 },
    { name: 'Baby Bib', price: 2.99 },
    { name: 'Baby Pacifier', price: 1.99 },
    { name: 'Baby Bottle', price: 3.99 },
    { name: 'Baby Blanket', price: 7.99 },
    { name: 'Baby Stroller', price: 49.99 },
    { name: 'Baby Car Seat', price: 39.99 },
    { name: 'Baby Carrier', price: 29.99 },
    { name: 'Baby Monitor', price: 19.99 },
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
