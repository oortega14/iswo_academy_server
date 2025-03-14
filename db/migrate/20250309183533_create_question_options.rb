class CreateQuestionOptions < ActiveRecord::Migration[7.2]
  def change
    create_table :question_options do |t|
      t.references :question, null: false, foreign_key: true
      t.string :content, null: false
      t.boolean :correct, default: false
      t.integer :position
      t.timestamps
    end
  end
end
