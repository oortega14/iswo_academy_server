class CreateAcademyConfigurations < ActiveRecord::Migration[7.2]
  def change
    create_table :academy_configurations do |t|
      t.string :domain, null: false, index: { unique: true }
      t.jsonb :colors, default: {}
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.references :academy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
