class CategoriesController < ApplicationController
  before_action :set_current_user, :set_cart

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end

  def search
    @categories = Category.all
    @products = Product.where("name ILIKE ?", "%#{params[:query]}%")
  end

  def meat
    load_category_products('Meat')
    @meat_products = @products
  end

  def milk_and_eggs
    milk_category = Category.find_by(name: 'Milk')
    eggs_category = Category.find_by(name: 'Eggs')

    # Ensure @dairy_products is always an array
    if milk_category && eggs_category
      # Filter products by the search query if it exists
      if params[:query].present?
        @dairy_products = Product.where(category: [milk_category, eggs_category])
                                 .where("name ILIKE ?", "%#{params[:query]}%")
      else
        @dairy_products = Product.where(category: [milk_category, eggs_category])
      end
    else
      @dairy_products = []  # Fallback to an empty array if categories are not found
      flash[:alert] = "Milk or Eggs category not found."
    end
  end

  def fruits
    load_category_products('Fruits')
    @fruits_products = @products
  end

  def vegetables
    load_category_products('Vegetables')
    @vegetables_products = @products
  end

  def cleaning
    load_category_products('Cleaning')
    @cleaning_products = @products
  end

  def fish
    load_category_products('Fish')
    @fish_products = @products
  end

  def drink
    load_category_products('Drinks')
    @drinks_products = @products
  end

  def bakery
    load_category_products('Bakery')
    @bakery_products = @products
  end

  def car
    load_category_products('Car')
    @car_products = @products
  end

  def frozen
    load_category_products('Frozen')
    @frozen_products = @products
  end

  def cold_cuts_and_cheeses
    load_category_products('Cold Cuts and Cheeses')
    @cold_cuts_and_cheeses_products = @products
  end

  def hygiene
    load_category_products('Hygiene')
    @hygiene_products = @products
  end

  def pasta
    load_category_products('Pasta')
    @pasta_products = @products
  end

  def snacks
    load_category_products('Snacks')
    @snacks_products = @products
  end

  def pharmacy
    load_category_products('Pharmacy')
    @pharmacy_products = @products
  end

  def baby
    load_category_products('Baby')
    @baby_products = @products
  end

  def pets
    load_category_products('Pets')
    @pets_products = @products
  end

  private

  def load_category_products(category_name)
    @category = Category.find_by(name: category_name)

    if @category
      if params[:query].present?
        @products = @category.products.where("name ILIKE ?", "%#{params[:query]}%")
      else
        @products = @category.products
      end
    else
      @products = []
      flash[:alert] = "#{category_name} category not found."
    end

    @cart = current_user&.cart
  end

  def load_multiple_category_products(category_names)
    categories = Category.where(name: category_names)

    if categories.any?
      @products = Product.where(category: categories)
    else
      @products = []
      flash[:alert] = "#{category_names.join(' or ')} category not found."
    end
  end

  def set_current_user
    @current_user = current_user # Replace with your logic to retrieve the current user
  end

  def set_cart
    @cart = current_user&.cart
  end
end
