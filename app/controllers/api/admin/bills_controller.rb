class Api::Admin::BillsController < ApplicationController

    def show
        begin
          user = User.find(params[:id])
            render json: user.as_json(include:{ bills: {include: { product_bills: {include: :product}}} })['bills']
        rescue  => e
          render json:{error: 'Error retrieting the user bills'}
        end
        
    end
      

    def index
        begin
            bill = Bill.all
            render json: bill.as_json(include:{ bills: {include: { product_bills: {include: :product}}} })['bills']
          rescue  => e
            render json:{error: 'Error retrieting the user bills'} 
        end   
    end

    def create
        begin    
          voucher = params[:voucher]
          product_data = params[:productData]
          unless voucher.present? && voucher.respond_to?(:tempfile)
            render json: { status: 'error', message: 'Voucher file is required' }, status: :bad_request
            return
        end
        
        ActiveRecord::Base.transaction do
            bill = Bill.new(payment_method_id: product_data[:payment_method_id], user_id: product_data[:user_id])
            bill.voucher.attach(voucher)
            
            if bill.save
              create_product_bills(bill, product_data[:products])
              render json: { message: 'A user bill has been created successfully' }, status: :created
            else
              render json: { message: "Failed to create the user bill #{bill.id}", errors: bill.errors.full_messages }, status: :unprocessable_entity
            end
          end
        rescue ActiveRecord::RecordInvalid => e
          render json: { message: "Invalid data: #{e.message}" }, status: :unprocessable_entity
        rescue ActiveStorage::IntegrityError => e
          render json: { status: 'error', message: 'Voucher upload failed: integrity error' }, status: :unprocessable_entity
        rescue ActiveStorage::UnidentifiedImageError => e
          render json: { status: 'error', message: 'Image upload failed: unidentified voucher' }, status: :unprocessable_entity
        end
    end

    private  

    def bills_params
        params.require(:bill).permit( :user_id, :payment_method_id, :user_id )
     end   
     
     def create_product_bills(bill, products)
        products.each do |product_info|
          product = Product.find(product_info[:productId])
          numbered_quantity = product_info[:quantity].to_i 
          if product.stock >= numbered_quantity

            numbered_price = product_info[:unitaryPrice].to_f
            total_amount = (numbered_quantity * numbered_price).to_f.round(2)

            bill.product_bills.create(
              product_id: product.id,
              quantity: numbered_quantity,
              cost: numbered_price,
              total: total_amount
              )

              newStock = product.stock - numbered_quantity

              product.update_attribute(:stock,newStock )
          else
              raise "Insufficient stock for product #{product.name}"
          end
        end
    end
  
end
