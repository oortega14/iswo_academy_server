class CreateAcademies < ActiveRecord::Migration[7.2]
  def change
    create_table :academies do |t|
      t.string :name, null: false
      t.text :description
      t.references :admin, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
