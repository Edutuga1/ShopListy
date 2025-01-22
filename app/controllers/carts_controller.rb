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
    @user = current_user
    @cart = current_user.cart
  end

  def add_product
    Rails.logger.info("Received params: #{params.inspect}")
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if current_cart
      current_cart.add_product(product, quantity)
      current_cart.save
    end

    respond_to do |format|
      format.html { redirect_to request.referer || root_path, notice: 'Product successfully added to cart!' }
      format.turbo_stream do
        render turbo_stream: turbo_stream.append('flash-messages', partial: 'shared/flash', locals: { message: 'Product added to cart!' })
      end
      format.json { render json: { message: 'Product added to cart!' }, status: :ok }
    end
  end

  def remove_item
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path, notice: 'Product removed from cart.'
  end

  def update_item
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.update(cart_item_params)
  end


  def add_to_list
    if params[:new_list_name].present?
      list = List.create(name: params[:new_list_name], user_id: current_user.id)
    else
      list = List.find(params[:list_id])
    end

    if params[:product_ids].present? && params[:quantities].present?
      params[:product_ids].each do |product_id|
        product = Product.find(product_id)
        quantity = params[:quantities][product_id].to_i
        list.add_product(product, quantity) if quantity.positive?
      end
    end

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
    @cart = current_user.cart
    if @cart
      @cart.cart_items.destroy_all
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
