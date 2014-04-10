class Name < ActiveRecord::Base
  belongs_to :game
  validates :content, uniqueness: true
end
