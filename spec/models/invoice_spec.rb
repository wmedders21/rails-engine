require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:merchant_id) }
    it { should validate_presence_of(:status) }
  end

  describe 'class methods' do
    it '#find_by_item_id' do
      merchant = create(:merchant)
      customer = Customer.create(first_name: "Willy", last_name: "Wonka")
      item_1 = create(:item, merchant_id: merchant.id)
      item_2 = create(:item, merchant_id: merchant.id)
      #invoice_0 has no items
      invoice_0 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: 'shipped')
      #invoice_1 has only 1 item: item_1
      invoice_1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: 'shipped')
      #invoice_2 has 2 items: both item_1 and item_2
      invoice_2 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: 'shipped')
      InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price)
      InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_1.unit_price)
      InvoiceItem.create(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_2.unit_price)

      expect(Invoice.find_by_item_id).to eq([invoice_1, invoice_2])
    end
  end
end
