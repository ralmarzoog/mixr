class Recipe 
  include Mongoid::Document
  include Mongoid::Paperclip
  field :title, type: String

  has_many :recipe_ingredients, dependent: :delete
  has_many :steps, dependent: :delete

  validates :title, presence: true, length: { minimum: 2, maximum: 255 }

  accepts_nested_attributes_for :recipe_ingredients, :steps

  has_mongoid_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  private
  
    def recipe_params
      params.require(:recipe).permit(:title)
    end
end
