class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :role, default: User.roles[:member]
      t.datetime :blocked_at, default: nil, index: true
      t.datetime :deleted_at, default: nil, index: true

      t.timestamps
    end
  end
end
