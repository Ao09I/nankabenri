class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      #空のデータはなしだよnull: false
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.boolean :is_assignment, default: false, null: false
      t.boolean :is_requirement, default: false, null: false

      t.timestamps

    end
  end
end
