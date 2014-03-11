class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  after_create :deliver_admin_email

  RATINGS = {
    'One Star'    => '1_star',
    'Two Stars'   => '2_stars',
    'Three Stars' => '3_stars',
    'Four Stars'  => '4_stars',
    'Five Stars'  => '5_stars'
  }

  validates :rating, :inclusion => {:in => (RATINGS.values + [nil, ''])}

  def controlled_by?(user)
    user == self.user && user.present?
  end



  private

  def deliver_admin_email
    return if self.place.user.blank?
    NotificationMailer.comment_added(self).deliver
  end
end
