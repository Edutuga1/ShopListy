class RecipesController < ApplicationController
  before_action :authenticate_user!

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to profile_path(current_user), notice: "Recipe added successfully."
    else
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :link, :description)
  end
end
