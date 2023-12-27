class Api::PeopleController < ApplicationController
    def show

        person = Person.find(params[:id])   
        
        render json: person
    end
end
