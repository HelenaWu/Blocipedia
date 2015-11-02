class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis # wikis owned by this user
  has_many :collaborations
  has_many :collaborated_wikis, through: :collaborations, source: :wiki

  # Sample code using new associations
  # current_user.wikis # returns owned wikis by current_user
  # current_user.collaborations # returns collaborations this user is involved in
  # current_user.collaborated_wikis

  def admin?
    tier == 'admin'
  end

  def premium?
    tier == 'premium'
  end

  def free?
    tier == 'free'    
  end

end
