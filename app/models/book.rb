class Book < ApplicationRecord
    
  #has_one_attached :image
  belongs_to :user #userの情報が必ず一つある

  #titleが存在しているかを確認するバリデーション
  validates :title, presence: true, length: { maximum: 200 }
  
  #bodyが存在しているかを確認するバリデーション
  validates :body, presence: true, length: { maximum: 200 }
  
end
