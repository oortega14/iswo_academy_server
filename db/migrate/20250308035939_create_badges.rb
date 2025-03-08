class CreateBadges < ActiveRecord::Migration[7.2]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.string :description
      t.string :icon
      t.timestamps
    end
  end
end
