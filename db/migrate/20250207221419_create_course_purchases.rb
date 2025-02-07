class CreateCoursePurchases < ActiveRecord::Migration[7.2]
  def change
    create_table :course_purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.decimal :amount_paid, precision: 10, scale: 2, null: false
      t.decimal :platform_fee, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
