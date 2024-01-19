class Api::Users::ProductsController < ApplicationController
    def index
      products = Product.all.includes(:product_pictures)
      render json: products.as_json(include: { product_pictures: { methods: :image_url } })
    end
  
    def show
      product = Product.find(params[:id])
      render json: product.as_json(include: { product_pictures: { methods: :image_url } })
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Product not found' }, status: :not_found
    end

    def random_six
        random_products = Product.order(Arel.sql('RAND()')).limit(2)
        render json: random_products.as_json(include: { product_pictures: { methods: :image_url } })
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
