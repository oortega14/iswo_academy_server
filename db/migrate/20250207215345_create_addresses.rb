class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.references :user_detail, null: false, foreign_key: true
      t.string :address
      t.string :city
      t.string :province
      t.string :country
      t.string :postal_code
      t.timestamps
    end
  end
end
