class Comment < ApplicationRecord
  acts_as_paranoid
  has_ancestry

  belongs_to :user
  belongs_to :post

  validates :message, presence: true
end
