class Airline < ApplicationRecord
  has_many :reviews

  before_create :slugify
  before_update :slugify

  def slugify
    self.slug = name.parameterize
  end

  def average_score
    reviews.average(:score).round(2).to_f
  end
end
