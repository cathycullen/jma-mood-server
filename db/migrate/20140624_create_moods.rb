class CreateMoods < ActiveRecord::Migration
  def change
    create_table :moods do |t|
      t.string :mood
      t.string :internal_external
      t.integer :user_id

      t.timestamps
    end
  end
end