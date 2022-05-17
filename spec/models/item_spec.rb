require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'relationships' do
    should { belong_to(:merchant) }
    should { have_many(:invoice_items) }
    should { have_many(:invoices).through(:invoice_items) }
    should { have_many(:transactions.through(:invoices) }
    should { have_many(:customers.through(:invoices) }
  end

  it 'validations' do
    should { validate_presence_of(:name) }
    should { validate_presence_of(:description) }
    should { validate_presence_of(:merchant_id) }
    should { validate_presence_of(:unit_price) }
    should { validate_numericality_of(:unit_price) }
  end
end
