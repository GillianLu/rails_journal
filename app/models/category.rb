class Category < ApplicationRecord
  belongs_to :user
  has_many :to_dos, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
end
