class CreateUserDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :user_details do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :birth_date, null: false
      t.integer :phone, null: false
      t.integer :dni, null: false
      t.integer :gender, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.string :province, null: false
      t.string :country, null: false
      t.string :postal_code, null: false

      t.timestamps
    end
  end
end
