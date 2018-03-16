class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, foreign_key: true
      t.string :email, null: false
      t.string :first_name, null: false, default: ''
      t.string :last_name, null: false, default: ''
      t.string :title, null: false, default: ''
      t.text :description, null: false, default: ''
      t.attachment :avatar

      t.timestamps
    end

    User.find_each { |user| user.create_profile(email: user.email) }
  end
end
