class Wiki < ActiveRecord::Base  
  extend FriendlyId
  friendly_id :subject, use: :slugged

  belongs_to :user # the owner of the wiki
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user

  def private?
    level == 'private'
  end
end
