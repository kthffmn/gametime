class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :description
      t.text :summary
      t.text :variations
      t.text :example
      t.integer :maximum
      t.integer :minimum
      t.integer :total_stars, :default => 0
      t.integer :num_of_reviews, :default => 0
      t.integer :average_rating, :default => 0
      t.integer :likes, :default => 0
      t.boolean :early_childhood
      t.boolean :elementary_school
      t.boolean :middle_school
      t.boolean :high_school
      t.boolean :college
      t.boolean :adulthood
      t.boolean :is_an_exercise

      t.timestamps
    end
  end
end
