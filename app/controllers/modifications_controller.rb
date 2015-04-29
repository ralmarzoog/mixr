class ModificationsController < ApplicationController
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

        @modification.original.recipe.email_subscribers
      end
    else 
      flash[:error] = "Nothing to modify."
    end
    redirect_to :back
  end


  private
    # Never trust params from the internet, only allow the white list through.
    def modification_params 
      params.require(:modification).permit(:suggestion, :value)
    end
end
