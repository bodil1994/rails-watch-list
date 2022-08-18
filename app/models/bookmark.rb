class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :comment, length: { minimum: 6 }
  validates :list_id, :movie_id, presence: true
  validates :list_id, uniqueness: { scope: :movie_id, message: "A bookmark for this movie in this list already exists" }
end
