class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :game_id
      t.integer :stars
    end
  end
end
