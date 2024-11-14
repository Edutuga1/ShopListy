class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :add_product, :remove_item, :update_item, :add_to_list, :update_product]
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
  end

  def add_product
    Rails.logger.info("Received params: #{params.inspect}")
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if current_cart
      current_cart.add_product(product, quantity)
      current_cart.save
    end

    # Set the notice message
    flash[:notice] = 'Product successfully added to cart!'

    # Redirect back to the referring URL (the page where the request originated)
    redirect_to request.referer || root_path
  end

  def remove_item
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path, notice: 'Product removed from cart.'
  end

  def update_item
    cart_item = @cart.cart_items.find(params[:id])
    if cart_item.update(cart_item_params)
      redirect_to cart_path, notice: 'Cart item updated.'
    else
      redirect_to cart_path, alert: 'Failed to update cart item.'
    end
  end

  def add_to_list
    # If the user is trying to create a new list
    if params[:new_list_name].present?
      # Create a new list with the provided name
      list = List.create(name: params[:new_list_name], user_id: current_user.id)
    else
      # If an existing list is selected, use that list
      list = List.find(params[:list_id])
    end

    # Now add products to the list
    if params[:product_ids].present? && params[:quantities].present?
      params[:product_ids].each do |product_id|
        product = Product.find(product_id)
        quantity = params[:quantities][product_id].to_i
        list.add_product(product, quantity) if quantity.positive?
      end
    end

    # Redirect or render based on your application's flow
    redirect_to cart_path, notice: 'Products added to list successfully!'
  end

  def update_product
    cart_item = @cart.cart_items.find(params[:id])
    if cart_item.update(cart_item_params)
      redirect_to cart_path, notice: 'Cart item updated successfully.'
    else
      redirect_to cart_path, alert: 'Failed to update cart item.'
    end
  end

  def clear
    @cart = current_user.cart # or wherever the cart is associated
    if @cart
      @cart.cart_items.destroy_all   # Delete all items in the cart
      flash[:notice] = "All items have been removed from your cart."
    else
      flash[:alert] = "Cart not found."
    end
    redirect_to cart_path(@cart)
  end


  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def set_current_user
    @user = current_user
  end

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
