class CreateAuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.belongs_to :user
      t.string :token

      t.timestamps
    end

    add_index :auth_tokens, :token
  end
end
