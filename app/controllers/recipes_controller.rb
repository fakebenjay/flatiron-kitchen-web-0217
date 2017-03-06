class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @ingredients = Ingredient.all
  end

  def create
    @recipe = Recipe.new(name: recipe_params[:name])
    @recipe.ingredients = Ingredient.where(id: recipe_params[:ingredient_id])

    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @ingredients = Ingredient.all
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.ingredients = Ingredient.where(id: recipe_params[:ingredient_id])

    if @recipe.update(name: recipe_params[:name])
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, ingredient_id: [])
  end
end
