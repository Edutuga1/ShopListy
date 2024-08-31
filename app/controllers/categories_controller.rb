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
    # Implement search logic here
  end

  def meat
    @meat_category = Category.find_by(name: 'Meat')

    if @meat_category
      @meat_products = @meat_category.products
    else
      @meat_products = []
      flash[:alert] = "Meat category not found."
    end

    @cart = current_user&.cart
  end

  def milk_and_eggs
    milk_category = Category.find_by(name: 'Milk')
    eggs_category = Category.find_by(name: 'Eggs')

    if milk_category && eggs_category
      @dairy_products = Product.where(category: [milk_category, eggs_category])
    else
      @dairy_products = Product.none
      flash[:alert] = "Milk or Eggs category not found."
    end
  end

  def fruits
    @fruits_category = Category.find_by(name: 'Fruits')

    if @fruits_category
      @fruits_products = @fruits_category.products
    else
      @fruits_products = []
      flash[:alert] = "Fruits category not found."
    end
  end

  def vegetables
    vegetables_category = Category.find_by(name: 'Vegetables')

    if vegetables_category
      @vegetables = vegetables_category.products
    else
      @vegetables = []
      flash[:alert] = "Vegetables category not found."
    end
  end

  def cleaning
    cleaning_category = Category.find_by(name: 'Cleaning')

    if cleaning_category
      @cleaning_products = cleaning_category.products
    else
      @cleaning_products = []
      flash[:alert] = "Cleaning category not found."
    end
  end

  def fish
    @fish_category = Category.find_by(name: 'Fish')

    if @fish_category
      @fish_products = @fish_category.products
    else
      @fish_products = []
      flash[:alert] = "Fish category not found."
    end
  end

  def drink
    @drinks_category = Category.find_by(name: 'Drinks')

    if @drinks_category
      @drinks_products = @drinks_category.products
    else
      @drinks_products = []
      flash[:alert] = "Drinks category not found."
    end
  end

  def bakery
    @bakery_category = Category.find_by(name: 'Bakery')

    if @bakery_category
      @bakery_products = @bakery_category.products
    else
      @bakery_products = []
      flash[:alert] = "Bakery category not found."
    end
  end

  def car
    @car_category = Category.find_by(name: 'Car')

    if @car_category
      @car_products = @car_category.products
    else
      @car_products = []
      flash[:alert] = "Car category not found."
    end
  end

  def frozen
    @frozen_category = Category.find_by(name: 'Frozen')

    if @frozen_category
      @frozen_products = @frozen_category.products
    else
      @frozen_products = []
      flash[:alert] = "Frozen category not found."
    end
  end

  def cold_cuts_and_cheeses
    @cold_cuts_and_cheeses_category = Category.find_by(name: 'Cold_cuts_and_cheeses')

    if @cold_cuts_and_cheeses_category
      @cold_cuts_and_cheeses_products = @cold_cuts_and_cheeses_category.products
    else
      @cold_cuts_and_cheeses_products = []
      flash[:alert] = "Cold cuts and cheeses category not found."
    end
  end

  def hygiene
    @hygiene_category = Category.find_by(name: 'Hygiene')

    if @hygiene_category
      @hygiene_products = @hygiene_category.products
    else
      @hygiene_products = []
      flash[:alert] = "Hygiene category not found."
    end
  end

  private

  def set_current_user
    @current_user = current_user # Replace with your logic to retrieve the current user
  end

  def set_cart
    @cart = current_user&.cart
  end
end
