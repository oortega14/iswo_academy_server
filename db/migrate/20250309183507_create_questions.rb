class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.references :assessment, null: false, foreign_key: true
      t.text :content, null: false
      t.integer :question_type, null: false, default: 0
      t.timestamps
    end
  end
end
