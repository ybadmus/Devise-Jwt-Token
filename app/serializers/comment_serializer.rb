class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :postedBy, :created_at, :updated_at

  def postedBy
    object.user.email
  end
end
