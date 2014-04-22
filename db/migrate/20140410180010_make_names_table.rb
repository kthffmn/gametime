class MakeNamesTable < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string :content
      t.integer :popularity, :default => 0
      t.integer :game_id
      t.string  :slug
      
      t.timestamps
    end
  end
end