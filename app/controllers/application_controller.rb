class ApplicationController < ActionController::API

    protected

    def authorization
      # making a request to a secure route, token must be included in the headers
      decode_data = decode_user_data(request.headers["token"])
      # getting user id from a nested JSON in an array.
      user_data = decode_data[0]["user_data"] unless !decode_data
      # binding.pry
      # find a user in the database to be sure token is for a real user
      # binding.pry

      # REVISAR ESTE LLAMADO A LA BASE DE DATOS 
      user = User.find(user_data)
  
      # The barebone of this is to return true or false, as a middleware
      # its main purpose is to grant access or return an error to the user
  
      if user && is_a_valid_token
        return true
      else
        render json: { message: "invalid access" }, status: :unauthorized
      end    
    end

    # turn user data (payload) to an encrypted string  [ A ]
    def encode_user_data(payload)

      payload[:exp] = Time.now.to_i + 3000
      # exp_payload = { user_data: payload[:user_data], exp: exp }

      begin
        token = JWT.encode payload, ENV["AUTHENTICATION_SECRET"], "HS256"
        
        session = JwtToken.create(token: token,exp_date: payload[:exp] ,user_id: payload[:user_data])
    
        token
        
      rescue => exception
          # Handle invalid token, e.g. logout user or deny access
      end
      
  
    end      

    # decode token and return user info, this returns an array, [payload and algorithms] [ A ]
  def decode_user_data(token)
    begin
      
      JWT.decode token, ENV["AUTHENTICATION_SECRET"], true, { algorithm: "HS256" }

    rescue JWT::ExpiredSignature
      render json: {message: "Invalid Token"}, status: :unauthorized
    rescue => e
      render json: {message: "invalid crendentials"}, status: 401
    end
  end

#   rails logger dentro del rescue para saber cuando hubo fallos
#   recomendacion de poner un secure para saber si se intento hacer un inicio de sesion




    def is_a_valid_token
      begin
        binding.break
        # db token
      token = JwtToken.find_by_token(request.headers["token"])
      # expiration date for db_token
      token.present? 
      rescue => exception
       Rails.logger("*** Method: is_a_valid_token failed, ERROR: #{exception.message} ")
       false
      end
    end    

end
