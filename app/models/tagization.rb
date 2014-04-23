class Tagization < ActiveRecord::Base
  belongs_to :game
  belongs_to :tag

  accepts_nested_attributes_for :tag
end