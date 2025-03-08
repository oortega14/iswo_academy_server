class CreateCourseDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :course_details do |t|
      t.references :course, null: false, foreign_key: true
      t.string :description
      t.string :type
      t.timestamps
    end
  end
end
