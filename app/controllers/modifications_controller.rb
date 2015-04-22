class ModificationsController < ApplicationController
  #before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /modifications/new
  def new
    @modification = Modification.new
    redirect_to :back
  end

  def create
    if params[:original_id]
      id = BSON::ObjectId.from_string(params[:original_id])
      original = RecipeIngredient.where(_id: id).first 
      original = Step.where(_id: id).first if original == nil
      unless original
        flash[:error] = "Error creating your modification."
      else
        @modification = Modification.create(suggestion: params[:suggestion], 
                                   original: original)
      end
    else 
      flash[:error] = "Nothing to modify."
    end
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
=begin
    def set_modification
      @modification = Modification.find(params[:id])
    end
=end
    # Never trust params from the internet, only allow the white list through.
    def modification_params 
      params.require(:modification).permit(:suggestion)
    end
end
