class MakeNamesTable < ActiveRecord::Migration
  def change
    create_table(:names) do |t|
      t.string :content
      t.integer :popularity
      t.integer :game_id
      t.timestamps
    end
  end
end