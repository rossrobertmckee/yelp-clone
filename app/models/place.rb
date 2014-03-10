class Place < ActiveRecord::Base
  validates :name, :presence => true
  validates :description, :presence => true

  belongs_to :user
  geocoded_by :address
  after_validation :geocode
  after_create :deliver_admin_email


  private

  def deliver_admin_email
    NotificationMailer.place_added(self).deliver
  end
end
