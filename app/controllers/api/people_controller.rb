class Api::PeopleController < ApplicationController
    # before_action :authorization
    before_action :find_person, only:[:show,:update, :create_phone_number]
    
    def create
        @person = Person.new(person_params)
    
        if @person.save
          render json: @person, status: :created
        else
            render json: { errors: @person.errors.full_messages }, status: :unprocessable_entity
        end
      end

    def show        
        render json: @person
    end

    def update

        if @person.update(person_params)
        render json: { message: 'A profile was successfully updated.' }, status: :ok
        else
        render json: { errors: @person.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def create_phone_number
        if params[:phone_number].present? 
          if @person.update_attributes(:phone_number, params[:phone_number])
            render json: { success: true, message: 'Phone number added successfully' }
          else
            puts @person.errors.full_messages.to_sentence  
            render json: { success: false, message: 'Failed to update phone number' }
          end
        else
          render json: { success: false, message: 'Invalid phone number format' }
        end
    end

    private

    def person_params
        params.require(:person).permit(:user_id,:user_name, :name, :lastname, :birthdate, :city, :country, :phone_number) 
    end

    def find_person
        @person = Person.find(params[:id])
    end

end
