class CreateUserAcademies < ActiveRecord::Migration[7.2]
  def change
    create_table :user_academies do |t|
      t.references :user, foreign_key: true
      t.references :academy, foreign_key: true, null: true
      t.integer :role, null: false, default: 0

      t.timestamps
    end
  end
end
