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
    if params[:new_list_name].present?
      if @user.lists.count >= 5
        flash[:alert] = "You can't create more than 5 lists."
        redirect_to cart_path and return
      end
      list = @user.lists.create(name: params[:new_list_name])
    else
      list = List.find(params[:list_id])
    end

    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if list.add_product(product, quantity)
      flash[:notice] = "Product added to the list."
    else
      flash[:alert] = "Failed to add the product to the list."
    end

    redirect_to cart_path
  end

  def update_product
    cart_item = @cart.cart_items.find(params[:id])
    if cart_item.update(cart_item_params)
      redirect_to cart_path, notice: 'Cart item updated successfully.'
    else
      redirect_to cart_path, alert: 'Failed to update cart item.'
    end
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
