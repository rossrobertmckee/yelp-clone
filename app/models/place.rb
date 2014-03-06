class Place < ActiveRecord::Base
  validates :name, :presence => true
  validates :lat, :presence => true
  validates :lng, :presence => true
  validates :description, :presence => true
end
