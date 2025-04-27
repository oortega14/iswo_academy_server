class CreateAcademies < ActiveRecord::Migration[7.2]
  def change
    create_table :academies do |t|
      t.string :name, null: false
      t.text :description
      t.string :slogan
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.references :category, null: false, foreign_key: { to_table: :academy_categories }

      t.timestamps
    end
  end
end
