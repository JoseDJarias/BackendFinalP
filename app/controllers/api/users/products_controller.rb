class Api::Users::ProductsController < ApplicationController
    def index
        products = Product.all
        render json: products
    end

    def show
        product = Product.find(params[:id])
        render json: product
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'Product not found' }, status: :not_found
    end

    def random_six
        random_products = Product.order(Arel.sql('RAND()')).limit(2)
        render json: random_products
    end    

    def products_by_category
        # category = Category.find_by(name: params[:category])
        # if category
        #     products_in_category = category.products
        #     render json: products_in_category
        # else
        #     render json: { error: 'Category not found' }, status: :not_found
        # end

        category = Category.find_by(id: params[:category_id])
        if category
            products_in_category = category.products
            render json: products_in_category
        else
            render json: { error: 'Category not found' }, status: :not_found
        end
    end
end
