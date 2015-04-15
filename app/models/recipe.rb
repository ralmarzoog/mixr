class Recipe 
  include Mongoid::Document
  field :title, type: String
  has_many :recipe_ingredients, dependent: :delete
  has_many :steps, dependent: :delete

  validates :title, presence: true, length: { minimum: 2, maximum: 255 }

  accepts_nested_attributes_for :recipe_ingredients, :steps

  private
  
    def recipe_params
      params.require(:recipe).permit(:title)
    end
end
