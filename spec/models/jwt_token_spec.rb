require 'rails_helper'

RSpec.describe JwtToken, type: :model do
  user = User.create(id:1,email: "arias@gmail.com", password:"123456") # Create a User record
  subject {
    described_class.new(
                        id:1,
                        token: "SaKiow902Al0sl20ssmw9d939d39d93dj39d9d",
                        exp_date: 1704396170,
                        user_id: user.id)
  }
  
  # Validaciones de atributos
  it { should validate_presence_of(:exp_date) }
  it { should validate_presence_of(:token) }

  it "is not valid without a user_id" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  it { should validate_uniqueness_of(:token) }
  it { should validate_uniqueness_of(:id) }


  # Validaciones de asociaciones
  it { should belong_to(:user) }

  # Validaciones de métodos de instancia
 
  it "validates exp_date is greater than current date to integer" do
    subject.exp_date = Time.now.to_i - 1
    expect(subject).not_to be_valid

    subject.exp_date = Time.now.to_i + 1
    expect(subject).to be_valid
  end

end
