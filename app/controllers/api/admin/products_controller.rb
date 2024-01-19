class Api::Admin::ProductsController < ApplicationController

    def create
      product = Product.new(product_params)
  
      if product.save
        render json: product, status: :created
      else
        render json: { error: product.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end 
    end

    def update
      product = Product.find(params[:id])
  
      if product.update(product_params)
        render json: { product: product, message: 'Product updated successfully' }, status: :ok
      else
        render json: { error: product.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end
  
    def available_state
      begin
        product = Product.find(params[:id])   
        # available_state = params[:available]
        if params[:available].present? && params[:available].to_s == 'true' 
          product.update_attribute(:available,true)
          puts "Product #{product.id} is now available: #{product.available}" 
          render json: { message: 'Available state toggled successfully', available: product.available }, status: :ok
          
        else 
          product.update_attribute(:available, false)
          puts "Product #{product.id} is now unavailable: #{product.available}"
          render json: { message: 'Available state toggled successfully', available: product.available }, status: :ok
  
        end
        
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Product not found' }, status: :not_found
      rescue StandardError => e
        puts "Error updating product: #{e.message}"
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end
  
    
    
  
    
      private
    
      def product_params
        params.require(:product).permit(
          :name,
          :description,
          :unitary_price,
          :purchase_price,
          :stock,
          :available,
          :category_id
        )
      end

      
      

end
