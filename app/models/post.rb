class Post < ApplicationRecord
  acts_as_paranoid
  acts_as_taggable

  before_validation :creating, on: %i[create update]

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one :profile,
          primary_key: :user_id,
          foreign_key: :user_id

  enum status: %i[draft posted blocked]

  validates :title, :body, :slug, presence: true
  validates :slug, :title, uniqueness: true

  private

  def creating
    self.slug = StringUtils.unique_slug(Post, title)
  end
end
