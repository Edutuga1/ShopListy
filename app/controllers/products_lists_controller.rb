class ProductsListsController < ApplicationController
  def update
    @products_list = ProductsList.find(params[:id])
    if @products_list.update(products_list_params)
      redirect_back(fallback_location: lists_path, notice: "Product list updated successfully.")
    else
      redirect_back(fallback_location: lists_path, alert: "Failed to update product list.")
    end
  end

  def destroy
    @products_list = ProductsList.find(params[:id])
    @products_list.destroy
    redirect_back(fallback_location: lists_path, notice: 'Product list was successfully deleted.')
  end

  private

  def products_list_params
    params.require(:products_list).permit(:quantity)
  end
end
