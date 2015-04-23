class Modification
  include Mongoid::Document
  field :suggestion, type: String

  belongs_to :original, polymorphic: true
  has_many :votes

  validates :suggestion, presence: true, length: { minimum: 2 }

=begin
  def add_vote(vote_value) 
    self[:vote_sum] = self[:vote_sum] || 0
    vote = self.votes.new(value: vote_value)
    if vote.save!
      self[:vote_sum] += vote_value
      save!
      true
    else
      false
    end
  end
=end

  def rating
    if self.votes.count > 0
      vote_sum = self.votes.all.inject(0) { |sum, vote| sum + vote.value }
      vote_sum / votes.count
    else
      0
    end
    #(self[:vote_sum] and self.votes.count > 0) ? self[:vote_sum] / self.votes.count.to_f : 0
  end
=begin
  def vote_sum
    self[:vote_sum]
  end
=end
  private
   # def vote_sum=(val)
      #write_attribute :vote_sum, val
    #end

end
