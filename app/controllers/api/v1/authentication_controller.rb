module Api
  module V1
    class AuthenticationController < ApplicationController
      before_action :authorize_request, except: :login

      # POST /auth/login
      def login
        @user = User.find_by_email(login_params[:email])
        if @user&.authenticate(login_params[:password])
          token = JsonWebToken.encode(user_id: @user.id)
          time = Time.now + 24.hours.to_i
          user_serializer =  UserSerializer.new(@user)
          render json: { id: @user.id, token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                         username: @user.username, email: @user.email, avatar: user_serializer.avatar}, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end

      private

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end
