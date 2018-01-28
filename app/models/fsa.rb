class Fsa < ApplicationRecord
  validates :name, presence: true

  validates :name, length: {is: 3}


  has_many :users

  geocoded_by :name
  after_validation :geocode

end
