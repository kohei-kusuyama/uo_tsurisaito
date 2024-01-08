class Post < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :tags, dependent: :destroy

  # has_one_attached :post
  has_one_attached :post_image



  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  def get_post_image
    (post_image.attached?) ? post_image: 'no_image.jpg'
  end

  # def self.search_for(content, method)
  #   if method == 'perfect'
  #     Post.where(title: content)
  #   elsif method == 'forward'
  #     Post.where('title LIKE ?', content + '%')
  #   elsif method == 'backward'
  #     Post.where('title LIKE ?', '%' + content)
  #   else
  #     Post.where('title LIKE ?', '%' + content + '%')
  #   end
  # end

  def self.search_for(content, method)
    method == 'forward'
      Post.where('category LIKE ? OR address LIKE ?', '%' + content + '%','%' + content + '%')
  end

  # def self.search_for(content, method)
  #   method == 'forward'
  #     Post.where(' LIKE ?', content + '%')
  # end

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :post_image, presence: true
  validates :category, presence: true
  validates :size, presence: true
  validates :address, presence: true
end
