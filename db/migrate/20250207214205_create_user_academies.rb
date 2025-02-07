class CreateUserAcademies < ActiveRecord::Migration[7.2]
  def change
    create_table :user_academies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :academy, null: false, foreign_key: true
      t.integer :role, null: false, default: 0

      t.timestamps
    end

    add_index :user_academies, [ :user_id ], unique: true
  end
end
