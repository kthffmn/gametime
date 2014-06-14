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
    
    popularity_values = game.names.collect{|name| name.popularity }
    num_of_popularity_values = popularity_values.length
    if num_of_popularity_values > 1 && popularity_values.include?(0)
      return game.errors[:base] << "Please select popularity value(s)."
    end
    unless num_of_popularity_values == popularity_values.uniq.length
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

  has_many :tagizations
  has_many :tags, :through => :tagizations
  accepts_nested_attributes_for :tags, allow_destroy: true

  has_many :tips
  accepts_nested_attributes_for :tips, allow_destroy: true

  has_many :reviews
  has_many :users, :through => :reviews

  has_many :variations
  accepts_nested_attributes_for :variations, allow_destroy: true

  validates :description, :presence => true, :length => { :minimum => 10, :maximum => 1000, :message => "must be between 10-1000 characters"}
  validates_numericality_of [:minimum, :maximum], :greater_than_or_equal_to => 1, only_integer: true
  validates_with GameValidator
    
  def sort_names_by_popularity
    self.names.sort{|a,b| b.popularity <=> a.popularity }
  end

  def most_popular_name
    sort_names_by_popularity.first
  end

  def most_popular_name_content
    sort_names_by_popularity.first.content
  end

  def less_popular_names
    self.multiple_names? ? sort_names_by_popularity[1..-1] : false
  end

  def multiple_names?
    self.names.count > 1 ? true : false
  end

  def all_ages?
    self.early_childhood && self.elementary_school && self.middle_school && self.high_school && self.college && self.adulthood ? true : false
  end

  before_save do |game|
    game.summary = /^(.*?)[.?!]\s/.match(game.description)[1] + "..."
    game.average_rating = game.total_stars / game.num_of_reviews
  end
  
end
