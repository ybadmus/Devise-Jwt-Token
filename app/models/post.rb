class Post < ApplicationRecord
  validates :title, presence: true, length: { in: 3...100 }
  validates :body, presence: true, length: { in: 20...1500 }

  validates_associated :user
  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }

  has_many :comments, dependent: :destroy
end