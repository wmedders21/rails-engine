require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    it '#name_search' do
      merchant_1 = create(:merchant, name: 'Turing')
      merchant_2 = create(:merchant, name: 'Ring World')
      merchant_3 = create(:merchant, name: 'Behringer')

      expect(Merchant.name_search('ring')).to eq([merchant_3, merchant_2, merchant_1])
    end
  end
end
