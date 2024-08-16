# db/seeds.rb

# Fetch the 'Meat' category
meat_category = Category.find_by(name: 'Meat')

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
    MeatProduct.find_or_create_by!(product_attributes.merge(category_id: meat_category.id))
  end
else
  puts "Error: 'Meat' category not found. Meat products not created."
end
