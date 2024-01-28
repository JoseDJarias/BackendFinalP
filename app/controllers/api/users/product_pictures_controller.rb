class Api::Users::ProductPicturesController < ApplicationController

    def index
        product_picture =  ProductPicture.all
        render json: product_picture
    end

    def show
        product_picture =  ProductPicture.find(params[:id])
        render json: product_picture
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'Product Picture not found' }, status: :not_found
    end


end
