class WelcomeController < ApplicationController
  def index
  	@recipies = Recipe.all#.sort{[x, y] x.rating <==> y.rating}
  end
end
