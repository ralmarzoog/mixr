class Modification
  include Mongoid::Document
  field :suggestion, type: String

  belongs_to :original, polymorphic: true
  has_many :votes

  validates :suggestion, presence: true, length: { minimum: 2 }


  def add_vote(vote_value) 
    self[:vote_sum] = self[:vote_sum] || 0
    vote = self.votes.new(value: vote_value)
    if vote.save!
      self[:vote_sum] += vote_value
      save!
    end
  end

  def rating
    (self[:vote_sum] and self.votes.count > 0) ? self[:vote_sum] / self.votes.count.to_f : 0
  end

  def vote_sum
    self[:vote_sum]
  end

  private
    def vote_sum=(val)
      write_attribute :vote_sum, val
    end
end
