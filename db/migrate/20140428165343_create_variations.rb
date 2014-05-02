class CreateVariations < ActiveRecord::Migration
  def change
    create_table :variations do |t|
      t.string :content
      t.integer :game_id
    end
  end
end
