class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :group_users, dependent: :destroy

  has_many :users, through: :group_users, source: :user

  validates :name, presence: true, uniqueness: true
  validates :introduction, presence: true

  has_one_attached :group_image

  def get_group_image(width, height)
  unless group_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    group_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  group_image.variant(resize_to_limit: [width, height]).processed
  end

  def is_owned_by?(user)
    owner.id == user.id
  end

  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end
end
