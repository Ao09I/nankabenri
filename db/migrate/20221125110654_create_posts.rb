class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      #空のデータはなしだよnull: false
      t.text :content, null: false
      #t.integer :user_id
      t.references :user, null: false, foreign_key: true
      #t.integer :thread_id
      #存在しているか判定　外部キー制約 foreign_key
      t.references :thread, null: false, foreign_key: true

      t.timestamps
    end
  end
end
