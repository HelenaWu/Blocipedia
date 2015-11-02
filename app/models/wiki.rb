class Wiki < ActiveRecord::Base  
  belongs_to :user # the owner of the wiki
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user

end
