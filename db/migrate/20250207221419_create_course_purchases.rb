class CreateCoursePurchases < ActiveRecord::Migration[7.2]
  def change
    create_table :course_purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.integer :status, default: 0
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
