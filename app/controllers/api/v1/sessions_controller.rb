# frozen_string_literal: true

class Api::V1::SessionsController < Api::V1::ApplicationController
  include Api::V1::Authenticate

  # create user session
  def create
    if (user = User.find_by_email(params[:email])) &&
       user.valid_password?(params[:password])
      render json: payload(user), status: :ok
    else
      render json: { error: (I18n.t 'users.unauthenticated').to_s },
             status: :unauthorized
    end
  end

  # destroy user session
  def destroy
    # decode JWT token and delete whitelisted on the basis of JTI
    payload = JsonWebToken.decode(request.headers['Authorization'])
    if payload && payload['jti'] && WhitelistedJwt.find_by_jti(payload['jti'])&.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

  swagger_controller :sessions, 'Session', resource_path: '/api/v1/sessions'

  swagger_api :create do
    summary 'Sign In'
    param :form, 'email', :string, :required, 'Email'
    param :form, 'password', :string, :required, 'password'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Sign Out'
    param :header, :Authorization, :string, :required, 'Auth Token'
    response :unprocessable_entity
  end
end
