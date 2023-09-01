class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy

  validates :email, presence: true
  validates :password, allow_blank: true, length: {minimum: 12}
end
