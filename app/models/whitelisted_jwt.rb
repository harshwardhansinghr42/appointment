# frozen_string_literal: true

class WhitelistedJwt < ApplicationRecord
  # making this polymorphic so that same table can be used in future
  # for saving doctor's auth tokens
  belongs_to :userable, polymorphic: true
end
