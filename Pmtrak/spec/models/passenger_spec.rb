require 'rails_helper'


RSpec.describe Passenger, type: :model do
  describe 'validations' do
    it 'is passenger valid with valid attributes' do
      passenger = FactoryBot.build(:passenger) 
      expect(passenger).to be_valid
    end

    it 'is passenger not valid without a blank phone number' do
      passenger = FactoryBot.build(:passenger, phone_number: nil)
      expect(passenger).not_to be_valid
    end

    it 'is passenger not valid with an invalid phone number format' do
      invalid_numbers_list = ['123-1234', '1234567890', '123-456-789']
      invalid_numbers_list.each do |invalid_phone|
        passenger = FactoryBot.build(:passenger, phone_number: invalid_phone)
        expect(passenger).not_to be_valid
      end
    end

    it 'is passenger not valid without a credit number' do
      passenger = FactoryBot.build(:passenger, credit_number: nil)
      expect(passenger).not_to be_valid
    end

    it 'is passenger not valid with an invalid credit number format' do
      invalid_credit_numbers_list = ['123456789011', '1234-5678-9012-345']
      invalid_credit_numbers_list.each do |invalid_credit|
        passenger = FactoryBot.build(:passenger, credit_number: invalid_credit)
        expect(passenger).not_to be_valid
      end
    end
  end

  # Add more test cases for associations, custom methods, etc.
end
