require 'rails_helper'

RSpec.describe Product, type: :model do
  subject(:product) { described_class.new }

  it "is invalid without a name" do
    expect(product).not_to be_valid
    expect(product.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a description" do
    expect(product).not_to be_valid
    expect(product.errors[:description]).to include("can't be blank")
  end

  it "is invalid without a unitary_price" do
    expect(product).not_to be_valid
    expect(product.errors[:unitary_price]).to include("can't be blank")
  end

  it "is invalid without a purchase_price" do
    expect(product).not_to be_valid
    expect(product.errors[:purchase_price]).to include("can't be blank")
  end

  it "is invalid without a stock" do
    expect(product).not_to be_valid
    expect(product.errors[:stock]).to include("can't be blank")
  end

  it "is invalid without availability information" do
    expect(product).not_to be_valid
    expect(product.errors[:available]).to include("can't be blank")
  end

  it "is invalid with a negative unitary_price" do
    product.unitary_price = -5
    expect(product).not_to be_valid
    expect(product.errors[:unitary_price]).to include("must be greater than or equal to 0")
  end

  it "is invalid with a negative purchase_price" do
    product.purchase_price = -10
    expect(product).not_to be_valid
    expect(product.errors[:purchase_price]).to include("must be greater than or equal to 0")
  end

  it "is invalid with a negative stock" do
    product.stock = -3
    expect(product).not_to be_valid
    expect(product.errors[:stock]).to include("must be greater than or equal to 0")
  end

  it "is valid with valid attributes" do
    product.name = "Valid Product"
    product.description = "Product description"
    product.unitary_price = 10
    product.purchase_price = 8
    product.stock = 100
    product.available = true
    expect(product).to be_valid
  end
end