class CreateAcademyCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :academy_categories do |t|
      t.string :name, null: false
      t.string :description

      t.timestamps
    end
  end
end
