class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :slug, :tag_list, :comments, :created_at

  def comments
    object.comments.all.arrange_serializable do |parent, children|
      CommentSerializer.new(parent, scope: { children: children })
    end
  end
end
