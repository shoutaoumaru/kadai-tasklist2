class Task < ApplicationRecord
  belongs_to :user
  
  #scope :recent, -> { order(created_at: :desc) }  # 追加
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :status, presence: true, length: { maximum: 10 }
end
