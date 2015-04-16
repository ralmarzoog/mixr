class Modification
  include Mongoid::Document
  field :suggestion, type: String

  belongs_to :original, polymorphic: true

  validates :suggestion, presence: true, length: { minimum: 2 }
end
