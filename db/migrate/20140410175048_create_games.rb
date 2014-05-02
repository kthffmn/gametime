class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :description
      t.text :variations
      t.text :example_script
      t.integer :maximum
      t.integer :minimum
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
