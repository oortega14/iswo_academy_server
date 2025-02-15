class CreateUserDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :user_details do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.date :birth_date
      t.string :phone
      t.string :dni
      t.integer :gender
      t.string :username, index: { unique: true }

      t.timestamps
    end
  end
end
