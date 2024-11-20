class ProductsListsController < ApplicationController
  def update
    @products_list = ProductsList.find(params[:id])
    if @products_list.update(products_list_params)
      redirect_to list_path(@products_list.list), notice: "Product list updated successfully."
    else
      redirect_to list_path(@products_list.list), alert: "Failed to update product list."
    end
  end

  private

  def products_list_params
    params.require(:products_list).permit(:quantity)
  end
end
