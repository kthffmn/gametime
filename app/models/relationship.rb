class Relationship < ActiveRecord::Base
  belongs_to :game
  belongs_to :relation, :class_name => 'Game'

  accepts_nested_attributes_for :relation
end