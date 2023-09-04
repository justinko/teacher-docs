class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :documents, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, allow_blank: true, length: {minimum: 12}
end
