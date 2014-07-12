class Review < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  before_save :update_num_of_reviews_and_total_stars

  private

    def update_num_of_reviews_and_total_stars
      review_num = self.game.num_of_reviews
      star_num = self.game.total_stars
      self.game.update(
        :num_of_reviews => review_num + 1, 
        :total_stars => star_num + self.stars
      )
    end
  # end private method
end
