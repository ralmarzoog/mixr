class SearchController < ApplicationController
	def search
    @all_recipes = Recipe.all

    @recipes = []
    search_terms = params[:search].downcase.split
    
    @all_recipes.each do |recipe|
      has_term = false
     
      title = recipe.title.downcase 
      search_terms.each do |term|
        if title.include?(term)
          has_term = true
        end
      end

      if has_term
        @recipes << recipe
      end
      has_term = false
    end

    render "search_results"
	end
end
