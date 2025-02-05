class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  
  # 名前が2文字以上、20字以下である
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  
  # 文字制限が50文字以下である
  validates :introduction, length: { maximum: 50 }
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
