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
    @recipe_votes_count = {}
    @recipe_avgs = {}
    dates = []
    @recipe.votes.each do |vote|
      date = vote.id.generation_time.to_date
      if !@recipe_avgs[date]
        dates << date
        @recipe_votes_count[date] = 1
        @recipe_avgs[date] = vote.value
      else
        @recipe_votes_count[date] += 1
        @recipe_avgs[date] += vote.value
      end
    end

    dates.each do |date|
      @recipe_avgs[date] = @recipe_avgs[date] / @recipe_votes_count[date]
    end

    @modifications = []
    @recipe.recipe_ingredients.each do |r_ingr|
      r_ingr.modifications.each do |mod|
        @modifications << mod
      end
    end

    @recipe.steps.each do |step|
      step.modifications.each do |step|
        @modifications << step
      end
    end

    set_cookies
    parsed_cookies = JSON.parse(cookies[:recipes_viewed])
    @recently_viewed = []
    parsed_cookies.each do |r_cookie|
      r = Recipe.where(id: r_cookie["id"]["$oid"])
      if r.empty?
        next
      end
      r = r.first
      next if r == @recipe
      @recently_viewed << r
    end
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
    @recipe = Recipe.new(title: params[:recipe][:title], image: params[:recipe][:image])
    recipe_ingredient_params = params[:recipe][:recipe_ingredients_attributes]
    steps_params = params[:recipe][:steps_attributes]

    respond_to do |format|
      if @recipe.save
        recipe_ingredient_params.each do |recipe_ingr|
          next unless (recipe_ingr[1][:quantity] and !recipe_ingr[1][:quantity].blank?) or (recipe_ingr[1][:ingredient] and !recipe_ingr[1][:ingredient].blank?)
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

    def set_cookies
      to_add = { id: @recipe.id, time: Time.now }
      if cookies[:recipes_viewed] == nil
        parsed_cookies = nil
      else
        parsed_cookies = JSON.parse(cookies[:recipes_viewed])
      end

      if parsed_cookies == nil or parsed_cookies.empty?
        parsed_cookies = [to_add]
        cookies[:recipes_viewed] = JSON.generate(parsed_cookies)
      elsif !parsed_cookies.select{ |e| e["id"] == JSON.parse(JSON.generate(to_add[:id])) }.empty?
        return
      elsif parsed_cookies.length < 6
        parsed_cookies << to_add
        cookies[:recipes_viewed] = JSON.generate(parsed_cookies)
      else
        parsed_cookies = parsed_cookies.sort do |x,y| 
          x[:time] <=> y[:time]
        end

        parsed_cookies[parsed_cookies.length - 1] = to_add
        cookies[:recipes_viewed] = JSON.generate(parsed_cookies)
      end
    end
end
