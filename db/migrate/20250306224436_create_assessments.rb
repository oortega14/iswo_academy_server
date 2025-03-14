class CreateAssessments < ActiveRecord::Migration[7.2]
  def change
    create_table :assessments do |t|
      t.references :teacher, null: false, foreign_key: { to_table: :users }
      t.references :course, null: false, foreign_key: true
      t.references :course_section, foreign_key: true, null: true
      t.string :type
      t.string :name
      t.integer :time_limit
      t.integer :max_attempts, default: 3, null: false
      t.integer :retry_after, default: 30, null: false
      t.integer :approve_with, default: 0, null: false
      t.timestamps
    end
  end
end
