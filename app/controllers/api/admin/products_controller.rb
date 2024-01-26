class Api::Admin::ProductsController < ApplicationController

  before_action :authorization
  before_action :find_product, only:[:available_state,:update,:update_stock]


    def create
      begin
        product = Product.new(product_params)
    
        if product.save
          render json: product, status: :created
        else
          render json: { error: product.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end 
      rescue
      end
      
    end

    def update
      begin 
    
        if @product.update(product_params)
          render json: { product: @product, message: 'Product updated successfully' }, status: :ok
        else
          render json: { error: @product.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
      rescue 
      end  
    end
  
    def available_state
      begin
        # available_state = params[:available]
        if params[:available].present? && params[:available].to_s == 'true' 
          @product.update_attribute(:available,true)
          puts "Product #{@product.id} is now available: #{@product.available}" 
          render json: { message: 'Available state toggled successfully', available: @product.available }, status: :ok
          
        else 
          @product.update_attribute(:available, false)
          puts "Product #{@product.id} is now unavailable: #{@product.available}"
          render json: { message: 'Available state toggled successfully', available: @product.available }, status: :ok
  
        end
        
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Product not found' }, status: :not_found
      rescue StandardError => e
        puts "Error updating product: #{e.message}"
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end

    def available_products
      begin
        products = Product.where(available: true)
        render json: products
      rescue
      end
      
    end

    def update_stock
      begin

        state = params[:state]
        
        stock = @product.stock
        
        if state.present?  
            @product.update(stock:(stock + 1))
            render json: {message: `The stock of the product #{@product} has been increase it, stock #{@product.stock}`}
        elsif stock > 0
           @product.update(stock:(stock - 1))
          render json: {message: `The stock of the product #{@product} has been decrease it, stock #{@product.stock}`}
        else
          render json: {error:`state params is not present`}
        end
        
      
        
      rescue StandardError => e
        puts "Error updating product: #{e.message}"
        render json: { error: e.message }, status: :unprocessable_entity
      end
      
    end
  
    

    private

    def find_product
      @product = Product.find(params[:id])
    end
  
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


    def check_active_state(item)
      ActiveRecord::Type::Boolean.new.cast(item)
    end
      
    

      
      

end
