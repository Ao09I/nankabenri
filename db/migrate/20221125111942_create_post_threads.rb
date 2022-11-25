class CreatePostThreads < ActiveRecord::Migration[7.0]
  def change
    create_table :post_threads do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
