class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :view_counts, dependent: :destroy

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  def self.search_for(content, method)
    if method == "perfect"
      User.where("name LIKE?", "#{content}")
    elsif method == "forward"
      User.where("name LIKE?", "#{content}%")
    elsif method == "backward"
      User.where("name LIKE?", "%#{content}")
    elsif method == "partial"
      User.where("name LIKE?", "%#{content}%")
    else
      User.all
    end
  end

  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join("app/assets/images/no_image.jpg")
    profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
