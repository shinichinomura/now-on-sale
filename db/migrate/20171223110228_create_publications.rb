class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
      t.integer :serial_id, limit: 8, null: false
      t.string :title, limit: 256, null: false
      t.date :date_min, null: false, index: true
      t.date :date_max, null: false, index: true

      t.timestamps
    end

    add_index :publications, [:serial_id, :title], unique: true
    add_foreign_key :publications, :serials, on_delete: :cascade, on_update: :cascade
  end
end
