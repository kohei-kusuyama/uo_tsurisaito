class Post < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  # has_one_attached :post
  has_one_attached :post_image



  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  def get_post_image
    (post_image.attached?) ? post_image: 'no_image.jpg'
  end


end
