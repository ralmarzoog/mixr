class WelcomeController < ApplicationController
  def index
  	@recipes = Recipe.all#.sort{[x, y] x.rating <==> y.rating}
  end
end
