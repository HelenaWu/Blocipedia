class Wiki < ActiveRecord::Base  
  extend FriendlyId
  friendly_id :subject, use: :slugged

  belongs_to :user # the owner of the wiki
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user

  def private?
    level == 'private'
  end
  def non_editors
  	exclude_user_ids = self.collaborators.collect{ |c| c.id} + [self.user.id]
  	User.where("id not in (?)", exclude_user_ids)
  end
end
