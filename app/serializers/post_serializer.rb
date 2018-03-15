class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :slug, :tag_list, :created_at
end
