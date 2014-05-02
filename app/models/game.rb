class GameValidator < ActiveModel::Validator
  def validate(game)
    if game.minimum > game.maximum
      game.errors[:base] << "Minimum must be less than or equal to maximum."
    end
    
    unless game.early_childhood  || game.elementary_school || game.adulthood ||
           game.middle_school    || game.high_school       || game.college
      game.errors[:base] << "Select an age group."
    end
    
    if game.names.length < 1
      game.errors[:base] << "Missing a name."
    end
    
    names = game.names.collect{|name| name.popularity }
    if names.length > 1 && names.include?(0)
      return game.errors[:base] << "Please select popularity value(s)."
    end
    unless names.length == names.uniq.length
      game.errors[:base] << "Select different popularity values."
    end
  end
end

class Game < ActiveRecord::Base
  # connections in alphebetical order
  has_many :names
  accepts_nested_attributes_for :names, allow_destroy: true

  has_many :relationships
  has_many :relations, :through => :relationships
  accepts_nested_attributes_for :relationships

  has_many :tagizations
  has_many :tags, :through => :tagizations
  accepts_nested_attributes_for :tagizations

  has_many :tips
  accepts_nested_attributes_for :tips, allow_destroy: true

  has_many :variations
  accepts_nested_attributes_for :variations, allow_destroy: true

  # validates :description, :presence => true, :length => { :minimum => 10, :maximum => 1000, :message => "must be between 10-1000 characters"}
  # validates_numericality_of [:minimum, :maximum], :greater_than_or_equal_to => 1, only_integer: true
  # validates_with GameValidator
    
  def sort_names_by_popularity
    self.names.sort{|a,b| a.popularity <=> b.popularity }
  end

  def most_popular_name
    sort_names_by_popularity.first
  end

  def most_popular_name_content
    most_popular_name.content
  end

  def less_popular_names
    if sort_names_by_popularity.count > 1 
      names[1..-1]
    else
      false
    end
  end

end
