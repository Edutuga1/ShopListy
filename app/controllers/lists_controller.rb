class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories, only: [:new, :create] # Only include existing actions
  before_action :set_user, only: [:new, :create]
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.find(params[:user_id])
    @list = @user.lists.build
    load_items
  end

  def show
    # @list is set by set_list
  end

  def create
    @user = User.find(params[:user_id])
    @list = @user.lists.build(list_params)

    if @list.save
      # Redirect to the user's lists page after saving
      redirect_to user_lists_path(@user)
    else
      # Reload items and re-render the form with errors
      load_items
      render :new
    end
  end

  def destroy
    @list.destroy
    redirect_to user_lists_path(@user), notice: 'List was successfully deleted.'
  end

  def index
    @user = User.find(params[:user_id])
    @lists = @user.lists
  end

  def edit
    # @list is already set by set_list before_action
  end

  def update
    if @list.update(list_params)
      redirect_to user_list_path(@user, @list), notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  private

  def load_items
    @hygiene_items = Item.where(category: 'Hygiene')
    @food_items = Item.where(category: 'Food')
    @cleaning_items = Item.where(category: 'House Cleaning')
  end

  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "User not found"
  end

  def set_list
    @list = @user.lists.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to user_lists_path(@user), alert: "List not found"
  end

  def set_categories
    @categories = Category.includes(:items).all
  end

  def list_params
    params.require(:list).permit(:name, item_ids: [])
  end
end
