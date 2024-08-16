class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :remove_item]
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
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    @cart.add_item(product, quantity)

    respond_to do |format|
      format.html { redirect_to cart_path, notice: 'Product added to cart.' }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("flash", partial: 'shared/flash_messages', locals: { notice: 'Product added to cart.' }) }
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Product not found.'
  end

  def remove_item
    cart_item = @cart.cart_items.find(params[:id])
    if cart_item
      cart_item.destroy
      flash[:notice] = "Item removed from cart."
    else
      flash[:alert] = "Item not found."
    end
    redirect_to cart_path
  end

  def update_item
    cart_item = @cart.cart_items.find(params[:id])
    quantity = params[:quantity].to_i

    if cart_item.update(quantity: quantity)
      redirect_to cart_path, notice: 'Item quantity updated.'
    else
      redirect_to cart_path, alert: 'Failed to update item quantity.'
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to cart_path, alert: 'Item not found.'
  end

  def add_to_list
    @list = List.find(params[:list_id])

    if @list.present?
      @cart.cart_items.each do |cart_item|
        items_list = @list.items_lists.find_or_initialize_by(item_id: cart_item.product_id)
        items_list.quantity = cart_item.quantity
        items_list.save
      end

      # Clear the cart if needed
      @cart.cart_items.destroy_all

      redirect_to cart_path, notice: 'Items added to list and cart cleared.'
    else
      redirect_to cart_path, alert: 'List not found.'
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to cart_path, alert: 'List not found.'
  end

  private

  def set_cart
    @cart = current_user.cart
  end

  def set_current_user
    @user = current_user
  end

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
