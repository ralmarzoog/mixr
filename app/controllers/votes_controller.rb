class VotesController < ApplicationController
  def new
    @vote = Vote.new
  end

  def create
    # When we add users, check if user has voted before and if so, update
    modification = Modification.find(params[:modification_id])
    @vote = Vote.create(modification: modification, value: params[:value])
    redirect_to :back, rating: @vote.modification.rating
  end

  private
    def vote_params
      params.require(:vote).permit(:value)
    end
end
