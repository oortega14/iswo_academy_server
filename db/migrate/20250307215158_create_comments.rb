class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :commentable, polymorphic: true, null: false
      t.text :body, null: false
      t.references :parent, foreign_key: { to_table: :comments }

      t.timestamps
    end
  end
end
