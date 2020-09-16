# frozen_string_literal: true

class CheckupAppointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :user, optional: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  scope :booked, -> { where.not(user_id: nil) }
  scope :free, -> { where(user_id: nil) }
end
