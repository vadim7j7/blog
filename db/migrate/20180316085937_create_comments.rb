class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :post, foreign_key: true
      t.text :message
      t.datetime :deleted_at, default: nil, index: true

      t.timestamps
    end
  end
end
