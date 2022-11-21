class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.text :goods
      t.string :price
      t.integer :date

      t.timestamps
    end
  end
end
