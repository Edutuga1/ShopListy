class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @lists = current_user.own_lists.includes(products: :category)
  end

  def show
    @list = List.find(params[:id])
    @friends = current_user.friends
  end

  def new
    @list = List.new
    @cart = User.find_by(id: session[:user_id])&.cart
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
    @list.destroy
    redirect_to lists_path, notice: 'List was successfully deleted.'
  end

  def share
    @friend = User.find(params[:friend_id])  # Get the selected friend
    @list = List.find(params[:id])           # Get the list to share
    @user = current_user                     # Get the current user

    # Send the share list email
    ListMailer.share_list(@friend, @list).deliver_now

    # Create a notification for the friend
    Notification.create!(
      user: @user,
      friend: @friend,
      list: @list,
      message: "#{@user.name} has shared a list with you: #{@list.name}",
      read: false
    )

    redirect_to list_path(@list), notice: "List shared successfully!"
  end

  def save_shared_list
    @list = List.find(params[:list_id]) # Use :list_id here
    current_user.saved_lists.create!(list: @list)
    redirect_to lists_path, notice: "List successfully saved to your Friends Shared Lists."
  rescue ActiveRecord::RecordInvalid => e
    redirect_to list_path(@list), alert: "Unable to save the list: #{e.message}"
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
