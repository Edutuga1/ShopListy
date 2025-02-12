class ProductsController < ApplicationController
  before_action :set_categories, only: [:new, :create]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    puts "Current User: #{current_user.inspect}"  # Debugging line

    if @product.save
      redirect_to(root_path(current_user), notice: 'Product was successfully created.')
    else
      render :new
    end
  end


  def show
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.all
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id)
  end

  def set_categories
    @categories = Category.all
  end
end
