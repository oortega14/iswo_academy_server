class CreateStudentTaskComments < ActiveRecord::Migration[7.2]
  def change
    create_table :student_task_comments do |t|
      t.text :content, null: false
      t.references :student_task, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
