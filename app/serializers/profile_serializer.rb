class ProfileSerializer < ActiveModel::Serializer
  attributes :email, :first_name, :last_name, :full_name,
             :small_name, :title, :description, :avatar

  def avatar
    return unless object.avatar.exists?

    { medium: object.avatar.url(:medium),
      thumb: object.avatar.url(:thumb) }
  end
end
