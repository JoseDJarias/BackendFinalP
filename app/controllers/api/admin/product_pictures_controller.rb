class Api::Admin::ProductPicturesController < ApplicationController

    
    # def create
    #   product_id = params[:product_id]
    #   image = params[:image]
    #     product_picture = ProductPicture.new(product_picture_params)

    #     if product_picture.save
    #       render json: { message: 'Product picture was successfully created.', product_picture: product_picture }
    #     else
            
    #       render json: { errors: product_picture.errors.full_messages }, status: :unprocessable_entity
    #     end
    # end
    def create
      # Use params to access form data
      product_id = params[:product_id]
      image = params[:image]
  
      # Validate that product_id is present (you can add more validations as needed)
      unless product_id.present?
        render json: { status: 'error', message: 'Product ID is required' }, status: :bad_request
        return
      end
  
      # Validate that image is present and is a file
      unless image.present? && image.respond_to?(:tempfile)
        render json: { status: 'error', message: 'Image file is required' }, status: :bad_request
        return
      end
  
      # Your logic to handle the data goes here
      # For example, you might create a new ProductPicture record:
  
      product_picture = ProductPicture.new(product_id: product_id)
  
      # Attach the uploaded image to the record
      product_picture.image.attach(image)
  
      # Save the record to the database
      if product_picture.save
        render json: { status: 'success', message: 'Product picture created successfully' }
      else
        render json: { status: 'error', message: 'Failed to create product picture', errors: product_picture.errors.full_messages }, status: :unprocessable_entity
      end
    end

    

 
  
end
