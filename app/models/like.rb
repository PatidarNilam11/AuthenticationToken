class Like < ApplicationRecord
  belongs_to :post 
  belongs_to :user

  after_save :update_like_counts

  default_scope {where(active: true)}
  scope :actives, -> {where(active: true)}

  def update_like_counts
    current_count = self.post.like_count.to_i
    total_count = self.active ? current_count + 1 : current_count - 1
    self.post.update(like_count: total_count)
  end
end
