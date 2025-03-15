class CreateBadgeRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :badge_requests do |t|
      t.timestamps
    end
  end
end
