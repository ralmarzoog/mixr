class ModificationsController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /modifications/new
  def new
    @modification = Modification.new
    debugger
    redirect_to :back
  end

  def create
    if params[:original_id]
      id = BSON::ObjectId.from_string(params[:original_id])
      debugger
      original = RecipeIngredient.where(_id: id).first 
      original = Step.where(_id: id).first if original == nil
      unless original
        flash[:error] = "Error creating your modification."
        redirect_to :back
      end
      debugger
      @modification = Modification.new(suggestion: params[:suggestion], 
                                 original: original)
    end
    debugger
    flash[:error] = "Nothing to modify."
    redirect_to :back
  end
=begin
  # GET /recipes/1/edit
  def edit
  end

  # POST /modifications
  # POST /modifications.json
  def create
    # @recipe = Recipe.new(title: params[:recipe][:title])

    respond_to do |format|
      if @modification.save

        format.html { redirect_to @modfication, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @modfication }
      else
        format.html { render :new }
        format.json { render json: @modfication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @modification.update(recipe_params)
        format.html { redirect_to @modfication, notice: 'Recipe was successfully updated.' }
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
=end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modification
      @modification = Modification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def modification_params 
      params.require(:modification).permit(:suggestion)
    end
end
