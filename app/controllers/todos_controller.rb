class TodosController < ApplicationController
    before_action :authentication
    
    def index
        users = User.all
        render json: users
    end
end
