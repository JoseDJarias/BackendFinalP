class Api::Admin::PaymentMethodsController < ApplicationController

  def index
    begin
      payment_methods = PaymentMethod.all
      render json: payment_methods, status: :ok
      
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Payment Methods not found' }, status: :not_found
    rescue StandardError => e
      puts "Error getting the Payments Methods: #{e.message}"
      render json: { error: e.message }, status: :unprocessable_entity
    
    end
    
  end

  def create 
    begin
        payment_method = PaymentMethod.new(payment_method_params)
        if payment_method.save
          render json: payment_method , status: :created
        end 
    rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
    end
  end


  def update
    begin
      if @payment_method.update(payment_method_params)
        render json: @payment_method, status: :ok
      else
        render json: { errors: @payment_method.errors.full_messages }, status: :unprocessable_entity
      end
    rescue StandardError => e
      handle_error(e, 'Error updating the Payment Method')
    end
  end


  def available_state
    begin
      payment = PaymentMethod.find(params[:id])   
      if params[:available].present? && params[:available].to_s == 'true' 
        payment.update_attribute(:available,true)
        puts "Payment #{payment.id} is now available: #{payment.available}" 
        render json: { message: 'Available state toggled successfully', available: payment.available }, status: :ok
      else 
        payment.update_attribute(:available, false)
        puts "Payment #{payment.id} is now unavailable: #{payment.available}"
        render json: { message: 'Available state toggled successfully', available: payment.available }, status: :ok
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Payment not found' }, status: :not_found
    rescue StandardError => e
      puts "Error updating Payment: #{e.message}"
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end


  def available_payment_methods
    begin
      payment = PaymentMethod.where(available: true)
            
      if payment.empty?
        render json: { message: 'No available Payments Methods found' }, status: :not_found
      else
        render json: payment, status: :ok
      end
    rescue StandardError => e
      render json: { error: "Error retrieving available Payments Methods: #{e.message}" }, status: :unprocessable_entity
    end
  end


  private
    
  def payment_method_params
    params.require(:payment_method).permit(:method, :available)
  end

end
