class SessionsController < ApplicationController

    # Use bcrypt for user authentication with password_digest -- a most--
    # Implementar una manera de expirar tokens
    
    # Utilizar una tabla llamado JWTokens para mantener sesiones, ejemplo:
    # expires_at = exp_time.to_i
    # payload[:exp] = expires_at
    # JWT.encode(payload, ENV['token_secret'], 'HS256')

    def signup
        user = User.new(email: params[:email], password: params[:password])
    
        # if user is saved
        if user.save
          # we encrypt user info using the pre-define methods in application controller
          token = encode_user_data({ user_data: user.id })
    
          # return to user
          render json: { token: token }, status: :created
        else
          # render error message
          render json: { message: "invalid credentials" }, status: :unauthorized
        end
      end
    
      def login
        user = User.find_by(email: params[:email])
    
        # you can use bcrypt to password authentication
        # search -------- bcrypt
        if user && user.password == params[:password]

          # we encrypt user info using the pre-define methods in application controller
          token = encode_user_data({ user_data: user.id })
    
          # return to user
          render json: { token: token }
        else
          render json: { message: "invalid credentials" }
        end
      end

      def logout

     
      end
end
