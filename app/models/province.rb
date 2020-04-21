class Province < ApplicationRecord
  has_many :users

  validates :name, :abbrev, presence: true
end
