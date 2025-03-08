class CreateStudentTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :student_tasks do |t|
      t.integer :status
      t.float :grade
      t.datetime :due_date
      t.references :teacher_task, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
