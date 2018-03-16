class Comment < ApplicationRecord
  acts_as_paranoid
  has_ancestry

  belongs_to :user
  belongs_to :post
  has_one :profile,
          primary_key: :user_id,
          foreign_key: :user_id

  validates :message, presence: true
end
