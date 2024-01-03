class Api::SessionsController < ApplicationController

    def signup
      begin
        user = User.new(email: params[:email])
        user.password = params[:password]
        # if user is saved
        if user.save
          # we encrypt user info using the pre-define methods in application controller
          token = encode_user_data({ user_data: user.id })
    
          # return to user
          render json: { token: token }, status: :created
        else
          render json: { message: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordInvalid => e
        render json: { message: "Invalid data: #{e.message}" }, status: :unprocessable_entity
      end
    end
    
    def login
      user = User.find_by(email: params[:email])

      if user && user.authenticate(params[:password])
        token = encode_user_data({ user_data: user.id })
        render json: { token: token }, status: :accepted
      else
        render json: { message: "Invalid credentials" }, status: :unauthorized
      end
    end

    def logout 
      db_token = JwtToken.find_by_token(request.headers["token"])
      
      if db_token.present?
        db_token.destroy 
        render json:{message:'Session destroyed'}, status: :ok
      else
        render json:{message:'Token not found'}, status: :not_found
      end
    end

      
end
