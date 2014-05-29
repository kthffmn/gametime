class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships, :force => true, :id => false do |t|
      t.integer "game_id", :null => false
      t.integer "relation_id", :null => false
      t.timestamps
    end
  end
end
  