class CreateAmazonItemAttributes < ActiveRecord::Migration[5.1]
  def change
    create_table :amazon_item_attributes do |t|
      t.integer :publication_id, null: false, limit: 8
      t.string :asin, null: false, limit: 64
      t.string :detail_page_url, null:false, limit: 1024

      t.timestamps
    end

    add_index :amazon_item_attributes, :publication_id, unique: true
    add_foreign_key :amazon_item_attributes, :publications, on_delete: :cascade, on_update: :cascade
  end
end
