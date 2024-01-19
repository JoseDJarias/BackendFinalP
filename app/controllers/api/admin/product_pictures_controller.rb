class Api::Admin::ProductPicturesController < ApplicationController

  def create
    begin  
      # puts "Received #{params[:image].length} picture groups"
      # Use params to access form data
      product_id = params[:product_id]
      image = params[:image]
      description = params[:description]
      
      # Validate product_id, description and image are present 
      unless product_id.present? 
        render json: { status: 'error', message: 'Product ID is required' }, status: :bad_request
        return
      end
      unless  description.present? 
        render json: { status: 'error', message: 'Description is required' }, status: :bad_request
        return
      end
      
      # Validate that image is present and is a file
      unless image.present? && image.respond_to?(:tempfile)
        render json: { status: 'error', message: 'Image file is required' }, status: :bad_request
        return
      end
      
      product_picture = ProductPicture.new(product_id: product_id, description: description)
      
      # Attach the uploaded image to the record
      product_picture.image.attach(image)
      
      if product_picture.save
        render json: { message: 'Product picture created successfully' }, status: :created
      else
        render json: { message: 'Failed to create the product picture', errors: product_picture.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveStorage::IntegrityError => e
      render json: { status: 'error', message: 'Image upload failed: integrity error' }, status: :unprocessable_entity
    rescue ActiveStorage::UnidentifiedImageError => e
      render json: { status: 'error', message: 'Image upload failed: unidentified image' }, status: :unprocessable_entity
    end
  end
end
