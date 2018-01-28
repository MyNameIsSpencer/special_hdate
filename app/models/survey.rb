class Survey < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :results
  has_many :questions, dependent: :destroy
end
