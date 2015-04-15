class RecipeIngredient
  include Mongoid::Document
  field :quantity, type: String
  
  belongs_to :ingredient
  belongs_to :recipe
end
