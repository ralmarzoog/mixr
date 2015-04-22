class VotesController < ApplicationController
  def new
    @vote = Vote.new
  end

  def create
    # When we add users, check if user has voted before and if so, update

  end

  private
    def vote_params 
      params.require(:vote).permit(:value)
    end
end
