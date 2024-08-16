class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  def index
    @lists = current_user.lists.includes(items: :category)
  end

  def show
  end

  def new
    @list = List.new
    @cart = User.find_by(id: session[:user_id])&.cart  # Assuming user retrieval
    render :new
  end

  def add_item
    list = List.find(params[:id])
    item = Item.find(params[:item_id])

    items_list = ItemsList.find_or_create_by(list_id: list.id, item_id: item.id)
    items_list.update(quantity: (items_list.quantity || 0) + 1)

    redirect_to list_path(list), notice: 'Item added to list'
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
  end

  def update
    if @list.update(list_params)
      redirect_to @list, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, notice: 'List was successfully destroyed.'
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :description)
  end

  def set_cart
    @cart = User.find_by(id: session[:user_id])&.cart
  end
end
