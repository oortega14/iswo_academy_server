class CreateStudentEnrollments < ActiveRecord::Migration[7.2]
  def change
    create_table :student_enrollments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :academy, null: false, foreign_key: true
      t.timestamps
    end
  end
end
