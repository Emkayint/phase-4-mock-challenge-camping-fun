class Camper < ApplicationRecord
  validates :name, presence: true
  validate :validate_age

  has_many  :signups
  has_many :activies, through: :signups

  def validate_age
    if age < 8 or age > 18
      errors.add(:age, "validation errors")
    end
  end
end
