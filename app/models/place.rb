class Place < ActiveRecord::Base
  validates :name, :presence => true
  validates :description, :presence => true

  belongs_to :user
  has_many :comments

  geocoded_by :address
  after_validation :geocode

end
