class User < ApplicationRecord
  acts_as_paranoid
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy

  after_create_commit :created

  enum role: %i[admin member]

  validates_presence_of :email, :password_digest
  validates :email, uniqueness: true

  accepts_nested_attributes_for :profile

  private

  def created
    create_profile(email: email) if profile.blank?
  end
end
