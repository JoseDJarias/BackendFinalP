class ApplicationController < ActionController::API

    protected

    def authorization
      begin
        # making a reques t to a secure route, token must be included in the headers
      decode_data = decode_user_data(request.headers["token"])
      # getting user id from a nested JSON in an array.
      user_data = decode_data[0]["user_data"] unless !decode_data

      # REVISAR ESTE LLAMADO A LA BASE DE DATOS 
      user = User.find(user_data)
  
      # The barebone of this is to return true or false, as a middleware
      # its main purpose is to grant access or return an error to the user
  
      if user && is_a_valid_token
        return true
      else
        Rails.logger("*** Method: authorization fails, ERROR: #{exception.message} ")
        render json: { message: "invalid access" }, status: :unauthorized
        
      end    
      rescue ActiveRecord::RecordNotFound
        Rails.logger("*** Method: authorization fails, ERROR: #{exception.message} ")
        render json: { error: 'invalid access' }, status: :unauthorized
        
      end
      
    end

    # turn user data (payload) to an encrypted string  [ A ]
    def encode_user_data(payload)

      payload[:exp] = Time.now.to_i + 60

      begin
        token = JWT.encode payload, ENV["AUTHENTICATION_SECRET"], "HS256"

        session = JwtToken.create(token: token,exp_date: payload[:exp] ,user_id: payload[:user_data])
    
        token
        
      rescue JWT::EncodeError=> exception
        Rails.logger.error("*** Method: encode_user_data fails, ERROR: #{exception.message} ")
        error_message = exception.message
        render json: { error: error_message }, status: :unprocessable_entity      
      end
      
  
    end      

    # decode token and return user info, this returns an array, [payload and algorithms] [ A ]
  def decode_user_data(token)
    begin
      
      JWT.decode token, ENV["AUTHENTICATION_SECRET"], true, { algorithm: "HS256" }

    rescue JWT::ExpiredSignature => exception
      Rails.logger.error("*** Method: decode_user_data fails, ERROR: #{exception.message} ")
      render json: {message: "Invalid Token"}, status: :unauthorized
    rescue => exception      
      Rails.logger.error("*** Method: decode_user_data fails, ERROR: #{exception.message} ")
      render json: {message: "invalid crendentials"}, status: 401
    end
  end


  def is_a_valid_token
    begin
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
