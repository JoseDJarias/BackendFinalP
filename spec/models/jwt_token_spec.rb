require 'rails_helper'

RSpec.describe JwtToken, type: :model do
  user = User.create(id:1,email: "arias@gmail.com", password:"123456") # Create a User record
  subject {
    described_class.new(
                        token: "SaKiow902Al0sl20ssmw9d939d39d93dj39d9d",
                        exp_date: 1704239893,
                        user_id: user.id)
  }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "is not valid without a token" do
    subject.token = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a exp_date" do
    subject.exp_date = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a user_id" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:user).without_validating_presence }
  end

  it "validates exp_date is greater than current date to integer" do
    subject.exp_date = Time.now.to_i - 1
    expect(subject).not_to be_valid

    subject.exp_date = Time.now.to_i + 1
    expect(subject).to be_valid
  end

  describe "validates uniques of token "do
  it { should validate_uniqueness_of(:token) }
  end  

  describe "validates uniques of token "do
  it { should validate_uniqueness_of(:id) }
  end  
  


end
