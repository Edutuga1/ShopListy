class ItemsController < ApplicationController
  def index
    @categories = Category.includes(:items)
  end
end
