class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.references :user_detail, null: false, foreign_key: true
      t.string :address, null: false
      t.string :city, null: false
      t.string :province, null: false
      t.string :country, null: false
      t.string :postal_code, null: false
      t.timestamps
    end
  end
end
