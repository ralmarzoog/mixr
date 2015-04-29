class SubscribersController < ApplicationController
  def create
    recipe = Recipe.find(params[:recipe_id])
    recipe.subscribers.create(email: params["subscriber"])
  end
end
