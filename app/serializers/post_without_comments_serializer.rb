class PostWithoutCommentsSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :postedBy, :created_at, :updated_at

  def postedBy
    object.user.email
  end
end
