class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :category_id, :dislike_count

  belongs_to :user
  belongs_to :category_id
  
  def dislike_count
    object.likes.where(active: false).count
  end
end
