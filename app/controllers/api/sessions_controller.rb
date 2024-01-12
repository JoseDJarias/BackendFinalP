class Api::SessionsController < ApplicationController

    def signup
      begin
        user = User.new(email: params[:email])
        user.password = params[:password]

        if User.exists?(email: user.email)
          render json: { message: 'Email is already taken' }, status: :unprocessable_entity
          return
        end

        if user.save
          
          person = Person.new(person_params.merge(user: user))

          if person.save
            # we encrypt user info using the pre-define methods in application controller
            token = encode_user_data({ user_data: user.id })

            # return to user
            data = {
              token: token,
              user_info: {
                id: user.id,
                email: user.email,
                person:person
                
              }
            }
            
            render json: { data: data }, status: :created
          else
            render json: { message: person.errors.full_messages.join(', ') }, status: :unprocessable_entity
          end  
        else
          render json: { message: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordInvalid => e
        render json: { message: "Invalid data: #{e.message}" }, status: :unprocessable_entity
      end
      rescue StandardError => e
        render json: { message: "Unexpected error: #{e.message}" }, status: :internal_server_error
      end
    end
      
    def login
      user = User.find_by(email: params[:email])

      if user && user.authenticate(params[:password])
        token = encode_user_data({ user_data: user.id })
        person = Person.find_by(user_id: user.id)
        data = {
          token: token,
          user_info: {
            id: user.id,
            email: user.email,
            person:person
            
          }
        }
        
        render json: { data:data }, status: :accepted
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

    def person_params
      params.require(:person).permit(:user_name, :name, :lastname, :birthdate, :city, :country) 
    end
      
