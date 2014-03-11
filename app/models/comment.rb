class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  after_create :deliver_admin_email

  RATINGS = {
    'one star'    => '1_star',
    'two stars'   => '2_stars',
    'three stars' => '3_stars',
    'four stars'  => '4_stars',
    'five stars'  => '5_stars'
  }

  validates :rating, :inclusion => {:in => (RATINGS.values + [nil, ''])}
  scope :five_star, -> { where(:rating => '5_stars') }

  def controlled_by?(user)
    user == self.user && user.present?
  end



  private

  def deliver_admin_email
    return if self.place.user.blank?
    NotificationMailer.comment_added(self).deliver
  end
end
