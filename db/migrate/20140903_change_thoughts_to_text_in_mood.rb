class ChangeThoughtsToTextInMood < ActiveRecord::Migration
  def up
    change_column :moods, :thoughts, :text
  end
end