class TodosController < ApplicationController
    before_action :authorization
    
    def index
        users = User.all
        render json: users
    end
end
