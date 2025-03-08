class CreateLessonProgresses < ActiveRecord::Migration[7.2]
  def change
    create_table :lesson_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.string :status, default: 'pending'
      t.datetime :started_at
      t.datetime :completed_at
      t.integer :progress_seconds, default: 0

      t.timestamps
    end

    add_index :lesson_progresses, [:user_id, :lesson_id], unique: true
  end
end
