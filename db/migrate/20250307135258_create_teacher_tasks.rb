class CreateTeacherTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :teacher_tasks do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.integer :status, default: 0
      t.datetime :deleted_at
      t.references :course, null: false, foreign_key: true
      t.references :course_section, foreign_key: true, null: true
      t.references :teacher, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
