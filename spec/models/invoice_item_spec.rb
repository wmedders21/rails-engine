require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it 'relationships' do
    should { belong_to(:invoice) }
    should { belong_to(:item) }
    should { have_one(:merchant).through(:invoices) }
    should { have_one(:customer).through(:invoices) }
  end

  it 'validations' do
    should { validate_presence_of(:item_id) }
    should { validate_presence_of(:invoice_id) }
  end
end
