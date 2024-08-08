class GroceriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @groceries = current_user.groceries
    render json: @groceries
  end

  def create
    @grocery = current_user.groceries.build(grocery_params)
    if @grocery.save
      render json: @grocery, status: :created
    else
      render json: @grocery.errors, status: :unprocessable_entity
    end
  end

  def update
    @grocery = current_user.groceries.find(params[:id])
    if @grocery.update(grocery_params)
      render json: @grocery
    else
      render json: @grocery.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @grocery = current_user.groceries.find(params[:id])
    @grocery.destroy
    head :no_content
  end

  private

  def grocery_params
    params.require(:grocery).permit(:name, :price, :bought)
  end
end
