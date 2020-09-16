# frozen_string_literal: true

class Api::V1::ApplicationController < ActionController::API
  Swagger::Docs::Generator.set_real_methods
  attr_reader :current_user

  protected

  def authenticate_user!
    authenticate_request!
    @current_user = User.find(auth_token[:user_id])
  end

  def authenticate_request!
    render json: { errors: [(I18n.t 'user_not_authenticated')] }, status: :unauthorized unless user_id_in_token?
  end

  private

  def auth_token
    @auth_token ||= JsonWebToken.decode(request.headers['Authorization'])
  end

  def user_id_in_token?
    auth_token && (WhitelistedJwt.find_by_jti(auth_token['jti'])&.userable_id == auth_token['user_id'])
  end
end
