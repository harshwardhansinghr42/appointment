# frozen_string_literal: true

class CheckupAppointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :user, optional: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
