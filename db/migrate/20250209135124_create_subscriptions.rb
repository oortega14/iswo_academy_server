class CreateSubscriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :academy, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :expired_at
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
