class CreateLessons < ActiveRecord::Migration[7.2]
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :description
      t.integer :position
      t.boolean :visible, default: false
      t.references :course_section, foreign_key: true, null: false
      t.timestamps
    end
  end
end
