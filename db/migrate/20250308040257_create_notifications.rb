class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.references :recipient, polymorphic: true, null: false
      t.references :notifiable, polymorphic: true, optional: true
      t.string :message, null: false
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
