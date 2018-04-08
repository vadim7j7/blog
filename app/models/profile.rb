class Profile < ApplicationRecord
  before_validation :creating, on: :create

  belongs_to :user, optional: true

  has_attached_file :avatar,
                    styles: { medium: '300x300>', thumb: '100x100' },
                    default_url: nil

  validates_attachment_content_type :avatar,
                                    content_type: /\Aimage\/.*\z/

  validates :email, uniqueness: true
  validates :first_name, :last_name, presence: true

  def full_name
    [first_name, last_name].join(' ').strip
  end

  def small_name
    tmp = [first_name.first, last_name.first].compact.join('').upcase
    tmp.blank? ? email.first.upcase : tmp
  end

  private

  def creating
    self.email = user.email
  end
end
