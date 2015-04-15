class Step
  include Mongoid::Document
  field :instruction, type: String
  belongs_to :recipe

  validates :instruction, presence: true, length: { minimum: 2, maximum: 255 }
end
