class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :places
  has_many :comments

  scope :admin, -> { where(:admin => true) }

  def can_edit?(p)
    return false if p.blank?

    p.user_id == self.id || self.admin
  end

  
end
