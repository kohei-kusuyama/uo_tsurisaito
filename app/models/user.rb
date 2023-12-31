class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  #ゲストログイン用
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "ゲスト"
    end
  end

  def guest
    email == GUEST_USER_EMAIL
  end

  def admin
    admin
  end

  has_many :post, dependent: :destroy
  has_one_attached :profile_image
  has_one_attached :back_image
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy


  def get_profile_image
    (profile_image&.attached?) ? profile_image : 'no_image.jpg'
  end
  def get_back_image
    (back_image&.attached?) ? back_image : 'no_image.jpg'
  end


  enum delivery_area:{
     "---選択してください":0,
     北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
     茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
     新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
     岐阜県:21,静岡県:22,愛知県:23,三重県:24,
     滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
     鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
     徳島県:36,香川県:37,愛媛県:38,高知県:39,
     福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
     沖縄県:47
   }

  # 検索機能
  # def self.search_for(content, method)
  #   if method == 'perfect'
  #     User.where(nickname: content)
  #   elsif method == 'forward'
  #     User.where('nickname LIKE ?', content + '%')
  #   elsif method == 'backward'
  #     User.where('nickname LIKE ?', '%' + content)
  #   else
  #     User.where('nickname LIKE ?', '%' + content + '%')
  #   end
  # end
  def self.search_for(content, method)
    method == 'forward'
      User.where('nickname LIKE ?', content + '%')
  end

  enum status: { active: 0, withdrawal: 1, stop: 2 }

  def active_for_authentication?
    super && (status == "active")
  end

  def name
    self.last_name+" "+self.first_name
  end

end
