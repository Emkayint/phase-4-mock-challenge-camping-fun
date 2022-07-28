class Signup < ApplicationRecord
  # validates :time, presence: true
  # validate :date_validation
  validates :time, inclusion: 0..23

  belongs_to :camper
  belongs_to :activity


  def date_validation

    if time
      if (time < 0 || time > 23)
        # byebug
        errors.add(:time, "validation error")
      end
    end
  end
end
