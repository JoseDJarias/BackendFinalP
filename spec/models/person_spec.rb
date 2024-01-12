# spec/models/person_spec.rb
require 'rails_helper'

RSpec.describe Person, type: :model do
  describe "validations" do
    let(:user) { User.create(email: "john@example.com", password: "password") }
    let(:valid_attributes) do
      {
        user: user,
        user_name: "johndoe",
        user_id: user.id,
        birthdate: "1990-01-01",
        name: "John",
        lastname: "Doe",
        city: "New York",
        country: "USA"
      }
    end

    subject { described_class.new(valid_attributes) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "validates user uniqueness" do
      subject.save
      duplicate_person = described_class.new(valid_attributes)
      expect(duplicate_person).not_to be_valid
    end

    it "validates presence of user_name" do
      subject.user_name = nil
      expect(subject).not_to be_valid
    end

    it "validates uniqueness of user_name" do
      subject.save
      duplicate_person = described_class.new(valid_attributes.merge(user_name: "JOHNDOE"))
      expect(duplicate_person).not_to be_valid
    end

    it "validates format of birthdate" do
        subject.birthdate = "1990/01/01" # Valid format
        expect(subject).to be_valid
      
        subject.birthdate = "1990-01-01" # Valid format
        expect(subject).to be_valid
    end

    it "validates length of name and lastname" do
      subject.name = "This name is too long" * 10
      subject.lastname = "This lastname is too long" * 10
      expect(subject).not_to be_valid
    end

    it "validates length of city and country" do
      subject.city = "A" * 51
      subject.country = "B" * 51
      expect(subject).not_to be_valid
    end
  end
end