class Tag < ActiveRecord::Base
  has_many :tagizations
  has_many :games, :through => :tagizations

  validates :name, :presence => true
end