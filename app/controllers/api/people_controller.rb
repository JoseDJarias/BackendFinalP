class Api::PeopleController < ApplicationController
    before_action :authorization

    def show

        person = Person.find(params[:id])   
        
        render json: person
    end

    def update
        @person = Person.find(params[:id])

        if @person.update(person_params)
        render json: { message: 'A profile was successfully updated.' }, status: :ok
        else
        render json: { errors: @person.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def person_params
        params.require(:person).permit(:name, :email, :password) # Adjust attributes based on your person model
    end

end
