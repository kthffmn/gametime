class CreateTagizationTable < ActiveRecord::Migration
  def change
    create_table :tagizations do |t|
      t.column :game_id, :integer
      t.column :tag_id, :integer
      
      t.timestamps
    end
  end
end