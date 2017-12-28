class CreateTwitterAuths < ActiveRecord::Migration[5.1]
  def change
    create_table :twitter_auths do |t|
      t.integer :user_id, null: false, limit: 8, index: { unique: true }
      t.integer :uid, null: false, limit: 8, index: { unique: true }
      t.string :nickname, null: false, limit: 64

      t.timestamps
    end

    add_foreign_key :twitter_auths, :users, on_delete: :cascade, on_update: :cascade
  end
end
