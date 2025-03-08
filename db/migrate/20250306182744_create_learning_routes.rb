class CreateLearningRoutes < ActiveRecord::Migration[7.2]
  def change
    create_table :learning_routes do |t|
      t.references :academy, null: false, foreign_key: true
      t.string :name, null: false
      t.string :description, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
