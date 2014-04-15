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
    unless names.length == names.uniq.length
      game.errors[:base] << "Select different popularity values."
    end

  end
end

class Game < ActiveRecord::Base
  has_many :names
  accepts_nested_attributes_for :names, allow_destroy: true

  validates :instructions, :presence => true, :length => { :minimum => 10, :maximum => 1000, :message => "must be between 10-1000 characters"}
  validates_numericality_of [:minimum, :maximum], :greater_than_or_equal_to => 2, only_integer: true

  validates_with GameValidator

  def sort_names_by_popularity
    self.names.sort{|a,b| a.popularity <=> b.popularity }
  end

  def most_popular_name
    sort_names_by_popularity.first
  end

  def less_popular_names
    names = sort_names_by_popularity
    names.count > 1 ? names[1..-1] : false
  end
end
