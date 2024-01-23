class Api::Admin::CategoriesController < ApplicationController

    def show
      begin
        category = Category.find(params[:id])
        render json: category, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Category not found' }, status: :not_found
      rescue StandardError => e
        puts "Error getting the categories: #{e.message}"
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end

      

    def create
      begin
        category = Category.new(category_params)
        if category.save
          render json: category, status: :created
        else
          render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
        end
      rescue StandardError => e
        puts "Error getting the categories: #{e.message}"
        render json: { error: e.message }, status: :unprocessable_entity  
      end
    end


    def index
      begin
        @categories = Category.all
        render json: @categories, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Category not found' }, status: :not_found
      rescue StandardError => e
        puts "Error getting the categories: #{e.message}"
        render json: { error: e.message }, status: :unprocessable_entity
      
      end  
    end


    def update
      begin
        if @category.update(category_params)
          render json: @category, status: :ok
        else
          render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
        end
        category = Category.where(available: true)
        render json: category
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Category not found' }, status: :not_found
      end
    end

    def available_state
      begin
        category = Category.find(params[:id])   
        if params[:available].present? && params[:available].to_s == 'true' 
          category.update_attribute(:available,true)
          puts "Category #{category.id} is now available: #{category.available}" 
          render json: { message: 'Available state toggled successfully', available: category.available }, status: :ok
        else 
          category.update_attribute(:available, false)
          puts "Category #{category.id} is now unavailable: #{category.available}"
          render json: { message: 'Available state toggled successfully', available: category.available }, status: :ok
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Category not found' }, status: :not_found
      rescue StandardError => e
        puts "Error updating Category: #{e.message}"
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end


    def available_categories
      begin
        category = Category.where(available: true)
              
        if category.empty?
          render json: { message: 'No available categories found' }, status: :not_found
        else
          render json: category, status: :ok
        end
      rescue StandardError => e
        render json: { error: "Error retrieving available categories: #{e.message}" }, status: :unprocessable_entity
      end
    end
      
      
      private
      
      def category_params
        params.require(:category).permit(:name,:available)
      end
      
end
