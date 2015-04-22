class Vote
  include Mongoid::Document
  field :value, type: Float

  # belongs_to :user # want it to have user id or something evenutally
  belongs_to :modification

  validates :value, presence: true, numericality: { greater_than_or_equal_to: 0,
                                                    less_than_or_equal_to: 5 }
end
