class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price
      t.string :media_url_1
      t.string :media_url_2
      t.string :media_url_3
      t.string :media_url_4
      t.datetime :start_time, null: false
      t.string :tweet_id, null: false


      t.timestamps
    end
  end
end
