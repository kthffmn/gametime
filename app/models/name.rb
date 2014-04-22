class Name < ActiveRecord::Base
  belongs_to :game
  validates :content, :presence => true

  def before_save_slugify
    self.slug = slugify(self.content)
  end 

  def slugify(string)
    string.downcase.gsub(" ", "-")
  end
end
