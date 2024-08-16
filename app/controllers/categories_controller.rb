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
      @meat_products = @meat_category.meat_products
    else
      @meat_products = []
      flash[:alert] = "Meat category not found."
    end

    @cart = current_user&.cart
  end


  def milk_and_eggs
    # Logic for displaying milk and eggs related content
  end
end

private

def set_current_user
  @current_user = current_user # Replace with your logic to retrieve the current user
end

def set_cart
  @cart = current_user&.cart
end
