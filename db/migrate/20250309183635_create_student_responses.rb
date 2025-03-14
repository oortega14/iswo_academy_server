class CreateStudentResponses < ActiveRecord::Migration[7.2]
  def change
    create_table :student_responses do |t|
      t.references :student_assessment, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :question_option, foreign_key: true, null: true
      t.text :answer_text, null: true
      t.boolean :correct, default: false
      t.timestamps
    end
  end
end
