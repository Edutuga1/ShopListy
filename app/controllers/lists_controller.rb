class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  def index
    @lists = current_user.lists.includes(products: :category)
  end

  def show
  end

  def new
    @list = List.new
    @cart = User.find_by(id: session[:user_id])&.cart  # Assuming user retrieval
    render :new
  end

  def add_product
    list = List.find(params[:id])
    product = Product.find(params[:product_id]) # Use Product model

    products_list = ProductsList.find_or_create_by(list_id: list.id, product_id: product.id)
    products_list.update(quantity: (products_list.quantity || 0) + 1)

    redirect_to list_path(list), notice: 'Product added to list'
  end


  def add_category
    list = List.find(params[:id]) # Use params[:id] to access list
    Category.find(params[:category_id]) # Use params[:category_id]

    redirect_to list_path(list), notice: 'Category added to list'
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    if @list.save
      redirect_to lists_path, notice: 'List was successfully created.'
    else
      render :new
    end
  end

  def edit
    @products_list = @list.products_lists.includes(:product)
  end

  def update
    @products_list = @list.products_lists.find(params[:id])  # Updated from items_lists to products_lists
    if @products_list.update(products_list_params)
      redirect_to edit_list_path(@list), notice: 'Quantity updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @products_list = @list.products_lists.find(params[:id])  # Updated from items_lists to products_lists
    @products_list.destroy
    redirect_to edit_list_path(@list), notice: 'Product removed successfully.'
  end

  private

  def set_user
    @user = current_user
  end

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :description)
  end

  def set_cart
    @cart = User.find_by(id: session[:user_id])&.cart
  end

  def products_list_params
    params.require(:products_list).permit(:quantity)
  end
end
