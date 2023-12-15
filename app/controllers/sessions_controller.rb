class SessionsController < ApplicationController

    # Use bcrypt for user authentication with password_digest -- a most--
    # Implementar una manera de expirar tokens
    
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
          render json: { message: "invalid credentials" },  status: :unauthorized
        end
      end

      def logout
        binding.break
        token = request.headers["token"]
        db_token = JwtToken.find_by_token(token)

        # Antes de hacer el render expire el token que le pasaron, porque sigue siendo válido.
        db_token.exp_date= -2.days.from_now
        # Si devolvió algo, entonces remuevalo
        db_token.destroy if db_token.present?
        
     
      end
end
