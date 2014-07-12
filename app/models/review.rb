class Review < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  before_save :update_num_of_reviews

  private

    def update_num_of_reviews
      original = self.game.num_of_reviews
      self.game.update(:num_of_reviews => original + 1)
    end
end
