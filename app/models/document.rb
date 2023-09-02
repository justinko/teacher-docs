class Document < ApplicationRecord
  belongs_to :user

  has_one_attached :file

  delegate :filename, :byte_size, to: :file
end
