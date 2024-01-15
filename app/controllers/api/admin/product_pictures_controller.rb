class Api::Admin::ProductPicturesController < ApplicationController
    def create
        product_picture = ProductPicture.new(product_picture_params)
    
        if params[:file].present?
          product_picture.source = encode_image(params[:file])
        end
    
        if product_picture.save
          render json: product_picture, status: :created
        else
          render json: product_picture.errors, status: :unprocessable_entity
        end
      end
    
      private
    
      def encode_image(file)
        binding.break
        puts "Original filename: #{file.original_filename}"
        puts "File path: #{file.path}"
      
        encoded_data = Base64.encode64(File.read(file.path))
        puts "Encoded data length: #{encoded_data.length}"
      
        {
          filename: file.original_filename,
          data: encoded_data,
          content_type: file.content_type
        }
      end
      
    
      def product_picture_params
        params.require(:product_picture).permit(:product_id)
      end
end
