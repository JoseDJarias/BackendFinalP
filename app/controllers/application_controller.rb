class ApplicationController < ActionController::API

    protected

    # how to change o make it more hidden
    SECRET = "yoursecretword"

    def authentication
        # making a request to a secure route, token must be included in the headers
        decode_data = decode_user_data(request.headers["token"])
        # getting user id from a nested JSON in an array.
        user_data = decode_data[0]["user_id"] unless !decode_data
        # find a user in the database to be sure token is for a real user

        # REVISAR ESTE LLAMADO A LA BASE DE DATOS 
        user = User.find(user_data&.id)
    
        # The barebone of this is to return true or false, as a middleware
        # its main purpose is to grant access or return an error to the user
    
        if user
          return true
        else
          render json: { message: "invalid credentials" }, status: 403
        end
      end

    # turn user data (payload) to an encrypted string  [ A ]
    def encode_user_data(payload)
        token = JWT.encode payload, SECRET, "HS256"
        return token
    end      

      # decode token and return user info, this returns an array, [payload and algorithms] [ A ]
  def decode_user_data(token)
    begin
      data = JWT.decode token, SECRET, true, { algorithm: "HS256" }
      return data
    rescue => e
      puts e
    end
  end
#   rails logger dentro del rescue para saber cuando hubo fallos
#   recomendacion de poner un secure para saber si se intento hacer un inicio de sesion

end
