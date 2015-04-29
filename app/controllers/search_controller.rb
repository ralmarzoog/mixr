class SearchController < ApplicationController
	def search
    @recipes = Recipe.all

    @recipes = @recipes.select do |recipe|
      recipe.title.downcase == params[:search].downcase
    end

    render "search_results"
	end
end
