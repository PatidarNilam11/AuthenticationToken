class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category 
  # has_one_attached :image
  has_many :likes,  dependent: :destroy
  validates :title, :presence => true
  validates :description, :presence => true
  
  def self.search(search)
    if search
      self.where("title like ?", "%#{search}%")
    else
      self.all
    end
  end
end