class CreateSocialNetworks < ActiveRecord::Migration[7.2]
  def change
    create_table :social_networks do |t|
      t.references :user_detail, null: false, foreign_key: true
      t.string :platform, null: false
      t.string :url, null: false
      t.timestamps
    end
  end
end
