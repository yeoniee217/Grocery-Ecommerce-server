class User < ApplicationRecord
  has_secure_password
  belongs_to :province

  validates :email, :password, :first_name, :last_name, :address, :province, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
