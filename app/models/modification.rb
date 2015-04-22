class Modification
  include Mongoid::Document
  field :suggestion, type: String

  belongs_to :original, polymorphic: true
  has_many :votes

  validates :suggestion, presence: true, length: { minimum: 2 }

  @vote_sum = 0

  def vote_sum
    @vote_sum
  end

  def add_vote(vote_value) 
    @vote_sum = @vote_sum || 0
    vote = self.votes.new(value: vote_value)
    if vote.save!
      @vote_sum += vote_value
    end
  end

  def rating
    (@vote_sum and self.votes.count > 0) ? self.vote_sum / self.votes.count : 0
  end
end
