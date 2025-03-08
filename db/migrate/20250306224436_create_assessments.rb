class CreateAssessments < ActiveRecord::Migration[7.2]
  def change
    create_table :assessments do |t|
      t.references :course, null: false, foreign_key: true
      t.references :course_section, foreign_key: true, null: true
      t.string :type
      t.string :name
      t.integer :time_limit
      t.integer :approve_with, default: 0
      t.timestamps
    end
  end
end
