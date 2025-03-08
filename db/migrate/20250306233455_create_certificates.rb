class CreateCertificates < ActiveRecord::Migration[7.2]
  def change
    create_table :certificates do |t|
      t.string :student_name
      t.string :course_title
      t.float :duration
      t.date :end_date
      t.uuid :code

      t.references :course, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
