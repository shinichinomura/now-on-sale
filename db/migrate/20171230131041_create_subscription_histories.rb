class CreateSubscriptionHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :subscription_histories do |t|
      t.integer :user_id, limit: 8, null: false, index: true
      t.integer :serial_id, limit: 8, null: false, index: true
      t.string :action, limit: 8, null: false

      t.timestamps
    end
  end
end
