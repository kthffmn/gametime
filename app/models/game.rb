class Game < ActiveRecord::Base
  has_many :names, :dependent => :destroy
  accepts_nested_attributes_for :names
end
