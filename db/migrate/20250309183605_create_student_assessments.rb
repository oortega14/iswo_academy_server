class CreateStudentAssessments < ActiveRecord::Migration[7.2]
  def change
    create_table :student_assessments do |t|
      t.references :assessment, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.integer :score, default: 0
      t.integer :status, default: 0
      t.string :type
      t.datetime :started_at
      t.datetime :last_attempt_at
      t.datetime :completed_at
      t.timestamps
    end
  end
end
