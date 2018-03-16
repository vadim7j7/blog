class CommentSerializer < ActiveModel::Serializer
  attributes :id, :message, :children, :created_at
  has_one :profile, key: :user

  def children
    return [] unless scope.class.to_s == 'Hash'

    scope[:children]
  end
end
