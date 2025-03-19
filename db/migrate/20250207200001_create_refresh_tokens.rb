class CreateRefreshTokens < ActiveRecord::Migration[7.2]
  def change
    create_table :refresh_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token, null: false, index: { unique: true }
      t.datetime :expires_at, null: false
      t.string :user_agent
      t.string :ip_address

      t.timestamps
    end
  end
end
