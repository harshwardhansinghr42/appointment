# frozen_string_literal: true

class JsonWebToken
  # create encoded token
  def self.encode(payload)
    "Bearer #{JWT.encode(payload, Rails.application.secrets.secret_key_base)}"
  end

  # decode jwt token
  def self.decode(request_header_auth)
    token = bearer_token(request_header_auth)
    HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base)[0])
  rescue StandardError
    nil
  end

  def self.bearer_token(request_header_auth)
    pattern = /^Bearer /
    header = request_header_auth
    header.gsub(pattern, '') if header&.match(pattern)
  end
end
