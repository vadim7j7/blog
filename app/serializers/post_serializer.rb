class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :slug, :tag_list, :comments, :created_at
  has_one :profile, key: :user

  def initialize(object, options={})
    meta_key = options[:meta_key] || :meta
    options[meta_key] ||= {}

    super(object, options)
  end

  def comments
    object.comments.all.arrange_serializable do |parent, children|
      CommentSerializer.new(parent, scope: { children: children })
    end
  end
end
