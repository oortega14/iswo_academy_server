class CreateSubscriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :academy, null: false, foreign_key: true
      t.decimal :amount
      t.integer :status

      t.timestamps
    end
  end
end
