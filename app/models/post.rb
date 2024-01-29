class Post < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :tags, dependent: :destroy

  has_one_attached :post_image



  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  def get_post_image
    (post_image.attached?) ? post_image: 'no_image.jpg'
  end
  
  def self.a_search_for(content)
      Post.where('address LIKE ?', '%' + content + '%')
  end
  
  def self.c_search_for(content)
      Post.where('category LIKE ?', '%' + content + '%')
  end

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :post_image, presence: true
  validates :category, presence: true
  validates :size, presence: true
  validates :address, presence: true
end
