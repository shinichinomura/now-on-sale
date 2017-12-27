class CreateSerials < ActiveRecord::Migration[5.1]
  def change
    create_table :serials do |t|
      t.string :title, limit: 256, null: false

      t.timestamps
    end
  end
end
