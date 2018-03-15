class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false, limit: 50_000
      t.string :slug, null: false
      t.integer :status, default: Post.statuses[:draft]
      t.datetime :deleted_at, default: nil, index: true

      t.timestamps
    end
  end
end
