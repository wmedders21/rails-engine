require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:merchant_id) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
  end

  describe 'class methods' do
    it '#name_search' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant_id: merchant.id, name: 'Turing')
      item_2 = create(:item, merchant_id: merchant.id, name: 'Ring World')
      item_3 = create(:item, merchant_id: merchant.id, name: 'Behringer')

      expect(Item.name_search('ring')).to eq([item_3, item_2, item_1])
    end

    it '#min_price_search' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant_id: merchant.id, name: 'Turing', unit_price: 33)
      item_2 = create(:item, merchant_id: merchant.id, name: 'Ring World', unit_price: 50)
      item_3 = create(:item, merchant_id: merchant.id, name: 'Behringer', unit_price: 100)

      expect(Item.min_price_search(40)).to eq([item_3, item_2])
    end
  end
end
