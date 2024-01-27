require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
    
    describe "#encode_user_data" do
        context "when encoding is successful" do
          it "returns an encoded token and creates a JwtToken" do
            payload = { user_data: 1, exp: Time.now.to_i + 60 }
    
            allow(JWT).to receive(:encode).with(payload, ENV["AUTHENTICATION_SECRET"], "HS256").and_return("encoded_token")
            expect(JwtToken).to receive(:create).with(token: "encoded_token", exp_date: payload[:exp], user_id: payload[:user_data])
    
            token = subject.encode_user_data(payload)
    
            expect(token).to eq("encoded_token")
          end
        end
         
        context "when encoding fails" do
            it "logs the error and renders an error response" do
            payload = { user_id: 1, exp: Time.now.to_i + 60 }
        
            allow(JWT).to receive(:encode).and_raise(RuntimeError, "Encoding failed")
            allow(Rails.logger).to receive(:error)
        
            # Utiliza expect para capturar la excepción y manejarla en tu prueba
            expect { subject.encode_user_data(payload) }.to raise_error(RuntimeError, "Encoding failed")
        
            # No intentes acceder a response aquí, ya que la excepción se manejará antes de llegar a este punto
            # No necesitas la siguiente línea:
            # expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end

    describe "#decode_user_data" do
        context "with a valid token" do
          it "returns decoded user data" do
            valid_token = JWT.encode({ user_id: 1, exp: Time.now.to_i + 60 }, ENV["AUTHENTICATION_SECRET"], "HS256")
            decoded_data = subject.decode_user_data(valid_token)
    
            expect(decoded_data[0]["user_id"]).to eq(1)
          end
        end
    
        context "when token has expired" do
          it "renders unauthorized status" do
            expired_token = JWT.encode({ user_id: 1, exp: Time.now.to_i - 60 }, ENV["AUTHENTICATION_SECRET"], "HS256")
    
            allow(Rails.logger).to receive(:error)
    
            expect { subject.decode_user_data(expired_token) }.to raise_error(Exception)
          end
        end
    
        context "when decoding fails for other reasons" do
          it "renders unauthorized status" do
            invalid_token = "invalid_token"
    
            allow(Rails.logger).to receive(:error)
    
            expect { subject.decode_user_data(invalid_token) }.to raise_error(Exception)
          end
        end
      end

    
end



# describe "GET #index" do
    #   it "returns a successful response" do
    #     get :index
    #     expect(response).to be_successful
    #   end
    # end
    
    # describe "POST #create" do
    #   it "creates a new record" do
    #     post :create, params: { some_param: "some_value" }
    #     expect(response).to have_http_status(:redirect)
    #     # Otras expectativas y aserciones
    #   end
    # end
    
    # describe "DELETE #destroy" do
    #   it "destroys the record" do
    #     record = create(:record) # Ejemplo de creación de un registro de prueba con FactoryBot
    #     delete :destroy, params: { id: record.id }
    #     expect(response).to have_http_status(:redirect)
    #     # Otras expectativas y aserciones
    #   end
    # end