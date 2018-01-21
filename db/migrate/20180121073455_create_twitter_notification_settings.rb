class CreateTwitterNotificationSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :twitter_notification_settings do |t|
      t.integer :user_id, null: false, limit: 8
      t.string :nickname, null: false, limit: 64, index: { unique: true }

      t.timestamps
    end

    add_index :twitter_notification_settings, :user_id, unique: true
    add_foreign_key :twitter_notification_settings, :users, on_delete: :cascade, on_update: :cascade
  end
end
