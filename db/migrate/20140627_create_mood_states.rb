class CreateMoodStates < ActiveRecord::Migration
  def change
    create_table :mood_states do |t|
      t.string :state
      t.integer :user_id
    end
  end
end