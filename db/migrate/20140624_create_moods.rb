class CreateMoods < ActiveRecord::Migration
  def change
    create_table :moods do |t|
      t.string :mood
      t.string :internal_external
      t.integer :user_id
      t.string :thoughts
      t.integer :energy_level

      t.timestamps
    end
  end
end