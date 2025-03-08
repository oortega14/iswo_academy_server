class CreateCertificateConfigurations < ActiveRecord::Migration[7.2]
  def change
    create_table :certificate_configurations do |t|
      t.string :course_name
      t.string :course_time

      t.references :course, foreign_key: true, null: false
      t.timestamps
    end
  end
end
