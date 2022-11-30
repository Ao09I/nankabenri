class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price
      t.datetime :start_time, null: false
      t.string :tweet_id, null: false


      t.timestamps
    end
  end
end
