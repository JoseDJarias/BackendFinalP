class Api::UserRolesController < ApplicationController
    def create
      @user_role = UserRole.new(user_role_params)
  
      if @user_role.save
        render json: @user_role, status: :created
      else
        render json: { errors: @user_role.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_role_params
      params.require(:user_role).permit(:user_id, :role_name)
    end
  
end
