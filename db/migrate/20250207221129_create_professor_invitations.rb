class CreateProfessorInvitations < ActiveRecord::Migration[7.2]
  def change
    create_table :professor_invitations do |t|
      t.string :email, null: false
      t.string :token, null: false, index: { unique: true }
      t.references :academy, null: false, foreign_key: true
      t.boolean :accepted, default: false
      t.timestamps
    end
  end
end
