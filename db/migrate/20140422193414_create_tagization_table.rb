class CreateTagizationTable < ActiveRecord::Migration
  def change
    create_table :tagizations, :id => false do |t|
      t.column :game_id, :integer
      t.column :tag_id, :integer
    end
  end
end