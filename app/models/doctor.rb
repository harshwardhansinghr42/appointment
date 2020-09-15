# frozen_string_literal: true

class Doctor < ApplicationRecord
  has_many :checkup_appointments
  validates :name, presence: true
end
