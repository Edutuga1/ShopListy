# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :set_cart
  before_action :set_current_user

  def create
    @cart_item = @cart.cart_items.new(cart_item_params)

    if @cart_item.save
      redirect_to cart_path, notice: 'Item added to cart.'
    else
      redirect_to cart_path, alert: 'Failed to add item to cart.'
    end
  end

  def show
    # @cart is set by the `set_cart` method
  end

  def add_item
    product = Product.find(params[:product_id]) # Ensure this matches your parameter name
    quantity = params[:quantity].to_i
    @cart.add_product(product, quantity)

    respond_to do |format|
      format.html { redirect_to cart_path(@cart), notice: 'Product added to cart.' }
      format.turbo_stream
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Product not found.'
  end

  private

  def set_cart
    @cart = current_user.cart
  end
  
  def set_current_user
    @user = current_user
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end
end
