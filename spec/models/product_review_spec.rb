require 'rails_helper'

RSpec.describe ProductReview, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:product) }
    it { should validate_presence_of(:review) }

  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
  end
end
