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

    def categories_index
      begin
        categories = Category.all
        render json: categories
      rescue StandardError => e
        render json: { error: "Error fetching categories: #{e.message}" }, status: :internal_server_error
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: 'Categories not found' }, status: :not_found
      end
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
            products_in_category = category.products.includes(:product_pictures)

            render json: products_in_category.as_json(include: { product_pictures: { methods: :image_url } })
        else
            render json: { error: 'Category not found' }, status: :not_found
        end
    end


    def filter_by_price_range
      begin
        min_price = params[:min_price]
        max_price = params[:max_price]
  
        # Filtra los productos por rango de precio usando tu modelo Product
        filtered_products = Product.where(unitary_price: min_price..max_price)
        render json: filtered_products.as_json(include: { product_pictures:{ methods: :image_url } })
      end
    rescue StandardError => e
      render json: { error: "Error fetching filter price range: #{e.message}" }, status: :internal_server_error
   
      

    end


    private 
    
    
end
