module Api::V1::Authenticate
  require 'securerandom'
  extend ActiveSupport::Concern

  # create auth_token payload
  def payload(user)
    jwt_token = create_jwt_token(user)
    {
      auth_token: jwt_token
    }
  end

  # create jwt token from user id and jti
  def create_jwt_token(user)
    jti = SecureRandom.uuid
    create_whitelisted_jwt(user, jti)
    JsonWebToken.encode(user_id: user.id, jti: jti)
  end

  def create_whitelisted_jwt(user, jti)
    user.whitelisted_jwts.create(jti: jti)
  end
end
