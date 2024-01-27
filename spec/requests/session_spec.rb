require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "signup actions" do
    it "creates a user and returns a token" do
        post "/api/signup", params: { email: "test@example.com", password: "password" }
      expect(response).to have_http_status(:created)
      
      json_response = JSON.parse(response.body)
      expect(json_response["token"]).to be_present
    end
    it "returns a validation error message" do
      post"/api/signup", params: { email: "invalid_email", password: "password" }
      expect(response).to have_http_status(:unprocessable_entity)
      
      json_response = JSON.parse(response.body)
      expect(json_response["message"]).to match(/Email is not in a valid format/)
    end  
    it "returns an error message" do
      # Crear un usuario existente para simular un registro duplicado
      User.create(email: "existing_user@example.com", password: "password")
      
      post"/api/signup", params: { email: "existing_user@example.com", password: "password" }
      expect(response).to have_http_status(:unprocessable_entity)
      
      json_response = JSON.parse(response.body)
      expect(json_response["message"]).to match(/Email has already been taken/)
    end     
    it "returns an error message" do
      post"/api/signup", params: { email: "", password: "password" }
      expect(response).to have_http_status(:unprocessable_entity)
      
      json_response = JSON.parse(response.body)
      expect(json_response["message"]).to match(/Email can't be blank/)
    end  
    it "returns an error message" do
      post"/api/signup", params: { email: "some@gmail.com", password: "" }
      expect(response).to have_http_status(:unprocessable_entity)
      
      json_response = JSON.parse(response.body)
      expect(json_response["message"]).to match(/Password can't be blank/)
    end
  end  

  describe "login actions" do
    let!(:user) { User.create(email: "test@example.com", password: "password") }
  
    it "returns a token for successful login" do
      post "/api/login", params: { email: user.email, password: "password" }
      expect(response).to have_http_status(:accepted)
  
      json_response = JSON.parse(response.body)
      expect(json_response["token"]).to be_present
    end
  
    it "returns an error message for invalid email" do
      post "/api/login", params: { email: "invalid@example.com", password: "password" }
      expect(response).to have_http_status(:unauthorized)
  
      json_response = JSON.parse(response.body)
      expect(json_response["message"]).to eq("Invalid credentials")
    end
  
    it "returns an error message for incorrect password" do
      post "/api/login", params: { email: user.email, password: "wrong_password" }
      expect(response).to have_http_status(:unauthorized)
  
      json_response = JSON.parse(response.body)
      expect(json_response["message"]).to eq("Invalid credentials")
    end
  
    it "returns an error message when email is missing" do
      post "/api/login", params: { password: "password" }
      expect(response).to have_http_status(:unauthorized)
  
      json_response = JSON.parse(response.body)
      expect(json_response["message"]).to eq("Invalid credentials")
    end
  
    it "returns an error message when password is missing" do
      post "/api/login", params: { email: user.email }
      expect(response).to have_http_status(:unauthorized)
  
      json_response = JSON.parse(response.body)
      expect(json_response["message"]).to eq("Invalid credentials")
    end
  end
  describe "logout actions" do
    let!(:user) { User.create(email: "test@example.com", password: "password") }
    let!(:token) { JwtToken.create(token: "valid_token", exp_date: Time.now + 3600, user_id: user.id) }
  
    context "when the token is found" do
      it "destroys the session and returns a success message" do
        headers = { "token" => token.token }
  
        expect { delete "/api/logout", headers: headers }.to change { JwtToken.count }.by(-1)
        expect(response).to have_http_status(:ok)
  
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("Session destroyed")
      end
    end
  
    context "when the token is not found" do
      it "returns a not found message" do
        headers = { "token" => "nonexistent_token" }
  
        expect { delete "/api/logout", headers: headers }.not_to change { JwtToken.count }
        expect(response).to have_http_status(:not_found)
  
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("Token not found")
      end
    end
  end


end
