class CreateEnrollments < ActiveRecord::Migration[7.2]
  def change
    create_table :enrollments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.integer :status, default: 0
      t.integer :progress, default: 0
      t.datetime :purchased_at

      t.timestamps
    end

    add_index :enrollments, [:user_id, :course_id], unique: true
  end
end
