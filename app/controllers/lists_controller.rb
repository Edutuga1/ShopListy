class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @lists = current_user.own_lists.includes(products: :category)
  end

  def new
    @list = List.new
    @categories = Category.all 
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
    product = Product.find(params[:product_id])

    products_list = ProductsList.find_or_create_by(list_id: list.id, product_id: product.id)
    products_list.update(quantity: (products_list.quantity || 0) + 1)

    redirect_to list_path(list), notice: 'Product added to list'
  end


  def add_category
    list = List.find(params[:id])
    Category.find(params[:category_id])

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
    @products_list = @list.products_lists.find(params[:id])
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

  def remove_saved
    saved_list = current_user.saved_lists.find_by(list_id: params[:id])

    if saved_list
      saved_list.destroy
      redirect_to lists_path, notice: t('lists_page.index.delete_success')
    else
      redirect_to lists_path, alert: t('lists_page.index.delete_failure')
    end
  end

  def share
    @friend = User.find(params[:friend_id])
    @list = List.find(params[:id])
    @user = current_user

    ListMailer.share_list(@friend, @list).deliver_now

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
    @list = List.find(params[:list_id])
    current_user.saved_lists.create!(list: @list)
    redirect_to lists_path, notice: "List successfully saved to your Friends Shared Lists."
  rescue ActiveRecord::RecordInvalid => e
    redirect_to list_path(@list), alert: "Unable to save the list: #{e.message}"
  end

  private

  def set_user
    @user = User.find(params[:user_id])
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
