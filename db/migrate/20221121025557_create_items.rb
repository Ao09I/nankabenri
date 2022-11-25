class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.text :goods, null: false
      t.integer :price, null: false
      t.date :date, null: false

      t.timestamps
    end
  end
end
