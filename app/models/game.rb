class Game < ActiveRecord::Base

  # alphebetical associations
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
  has_many :reviewers, :through => :reviews, :source => :user

  has_many :variations
  accepts_nested_attributes_for :variations, allow_destroy: true

  # alphebetical validations
  validates :description, :presence => true, :length => { :minimum => 10, :maximum => 3000, :message => "must be between 10-3000 characters"}
  validates_numericality_of [:minimum, :maximum], :greater_than_or_equal_to => 1, only_integer: true
  validate :age_group_validation, :max_not_smaller_than_min_validation, :name_validation, :popularity_validation

  # ActiveRecord instructions
  before_save :update_summary

  # instance methods
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

  def average_rating
    if self.num_of_reviews > 0
      self.total_stars / self.num_of_reviews
    else
      "N/A"
    end
  end
  
  # class methods would go below here

  private

    # before_save 
    # this could slow down the program becuase it's triggered regardless of what was changed
    def update_summary
      if self.description != nil
        shortened = /^(.*?)[.?!]\s/.match(self.description)
        if shortened
          self.summary = shortened[1] + "..."
        end
      end
    end

    # validation methods
    def age_group_validation
      unless self.early_childhood  || self.elementary_school || self.adulthood ||
             self.middle_school    || self.high_school       || self.college
        errors.add(:adulthood, "Select an age group.")
      end
    end

    def max_not_smaller_than_min_validation
      if self.minimum > self.maximum
        errors.add(:maximum, "Minimum must be less than or equal to maximum.")
      end
    end

    def name_validation
      if self.names.length < 1
         errors.add(:name_ids, "Missing a name.")
      end
    end
  
    def popularity_validation
      popularity_values = self.names.collect{|name| name.popularity }
      num_of_popularity_values = popularity_values.length
      if num_of_popularity_values > 1 && popularity_values.include?(0)
        errors.add(:name_ids, "Please select popularity value(s).")
      end
    end
  # end of private method
end
