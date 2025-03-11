class ProductsController < ApplicationController
  before_action :set_categories, only: [:new, :create]

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      redirect_to root_path(current_user), notice: 'Product was successfully created.'
    else
      puts @product.errors.full_messages
      flash[:alert] = "Failed to create product: #{@product.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.user_id == current_user.id
      @product.destroy
      flash[:notice] = "Product removed successfully."
    else
      flash[:alert] = "You can't remove this product."
    end

    redirect_back fallback_location: products_path
  end

  def index
    @products = Product.all
    @category = Category.find_by(id: params[:category_id])

    if @category
      @products = @category.products.where(user_id: current_user.id)
    else
      @products = Product.where(user_id: current_user.id)
    end
  end

  private

  def product_is_seeded?(product)
    product.created_at < Time.current - 1.hour
  end


  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id)
  end

  def set_categories
    @categories = Category.all
  end
end
