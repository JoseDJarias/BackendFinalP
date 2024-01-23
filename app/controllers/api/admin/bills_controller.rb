class Api::Admin::BillsController < ApplicationController

    def show
        begin
            bill = Bill.find(params[:id])
            render json: bill.as_json(include: { bills: { methods: :image_url } })
        rescue  
        end
        
    end
      

    def index
        begin
            bill = Bill.all
            render json: bill.as_json(include: { bills: { methods: :image_url } })
        rescue 
        ensure
        end
        
   
    end
    def create
        begin  
        voucher = params[:voucher]
    
        # Validate that image is present and is a file
        unless voucher.present? && voucher.respond_to?(:tempfile)
            render json: { status: 'error', message: 'Voucher file is required' }, status: :bad_request
            return
        end
        
        bill = Bill.new(payment_method: payment_method, user_id: user_id,)
        
        # Attach the uploaded image to the record
        bill.image.attach(voucher)
        
        if bill.save
            render json: { message: 'A user bill has been created successfully' }, status: :created
        else
            render json: { message: `Failed to create the user bill #{bill.id}`, errors: bill.errors.full_messages }, status: :unprocessable_entity
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
        params.require(:bill).permit( :user_id, :payment_method_id )
     end   

     def create_bills_products
        @stock = {
            1 => {
                quantity: 2,
                cost: 2000
            },
            2 => {
                quantity: 1,
                cost: 5000
            },
        }
        begin
            @products.each do |product|
                @bill.product_bills.create(
                    product_id:product.id,
                    quantity:@stock[product.id][:quantity],
                    cost:@stock[product.id][:cost],
                    total:4000
                )

            end
          
        rescue 
        end
        
     end
    
end
