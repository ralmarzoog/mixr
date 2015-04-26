class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    3.times { @recipe.recipe_ingredients.build }
    3.times { @recipe.steps.build }
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    debugger
    @recipe = Recipe.new(title: params[:recipe][:title], image: params[:recipe][:image])
    recipe_ingredient_params = params[:recipe][:recipe_ingredients_attributes]
    steps_params = params[:recipe][:steps_attributes]

    respond_to do |format|
      if @recipe.save
        recipe_ingredient_params.each do |recipe_ingr|
          next unless recipe_ingr[1][:quantity] or recipe_ingr[1][:ingredient]
          quantity = recipe_ingr[1][:quantity]
          ingr_name = recipe_ingr[1][:ingredient].downcase
          ingr = Ingredient.where(name: ingr_name).first
          ingr = ingr || Ingredient.create(name: ingr_name)
          @recipe.recipe_ingredients.create(quantity: quantity, ingredient: ingr)
        end

        steps_params.each do |s|
          step = s[1]
          instr =  step[:instruction]
          next unless instr
          @recipe.steps.create(instruction: instr)
        end

        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:title, :image)
    end
end
