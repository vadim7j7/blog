class User < ApplicationRecord
  acts_as_paranoid
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum role: %i[admin member]

  validates_presence_of :email, :password_digest
  validates :email, uniqueness: true
end
