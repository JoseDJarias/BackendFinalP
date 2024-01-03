require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { described_class.new }

  it "is invalid without an email" do
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password" do
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid with an invalid email format" do
    user.email = "invalid_email"
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("is not in a valid format")
  end

  it "is invalid with a password shorter than the minimum length" do
    user.password = "abc"
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include("is too short (minimum is 4 characters)")
  end

  it "is invalid with a password longer than the maximum length" do
    user.password = "a" * 21
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include("is too long (maximum is 20 characters)")
  end

  it "is invalid with a duplicate email" do
    existing_model = User.create(email: "example@example.com",password:"valid_123456")
    user.email = existing_model.email
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is valid with valid attributes" do
    user.email = "valid@example.com"
    user.password = "valid_password"
    expect(user).to be_valid
  end



end
