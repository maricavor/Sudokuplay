class CreateGames < ActiveRecord::Migration
  def change
     create_table :games do |t|
      t.integer :player_id, :default => nil
      t.string  :player_ip
      t.integer :puzzle_id
      t.datetime :start
      t.integer :playtime
      t.boolean :solved, :default => false
      t.boolean :revealed, :default => false
      t.integer :mistakes
      t.integer :hints
      t.timestamps null: false
    end
  end
end
 