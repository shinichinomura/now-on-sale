class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id, null: false, limit: 8
      t.integer :serial_id, null: false, limit: 8

      t.timestamps
    end

    add_index :subscriptions, [:user_id, :serial_id], unique: true
    add_foreign_key :subscriptions, :users, on_delete: :cascade, on_update: :cascade
    add_foreign_key :subscriptions, :serials, on_delete: :cascade, on_update: :cascade
  end
end
