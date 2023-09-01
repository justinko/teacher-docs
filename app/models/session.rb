class Session < ApplicationRecord
  belongs_to :user

  validates :user_agent, :ip_address, presence: true
end
