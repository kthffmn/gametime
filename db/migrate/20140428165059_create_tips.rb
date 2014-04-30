class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :content
      t.integer :game_id

      t.timestamps
    end
  end
end