class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_and_belongs_to_many :wikis  

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def free?
    role == 'free'    
  end

end