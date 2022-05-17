require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it 'relationships' do
    should { belong_to(:merchant) }
    should { belong_to(:customer) }
    should { have_many(:transactions) }
    should { have_many(:invoice_items) }
    should { have_many(:items).through(:invoice_items) }
  end

  it 'validations' do
    should { validate_presence_of(:customer_id) }
    should { validate_presence_of(:merchant_id) }
    should { validate_presence_of(:status) }
  end
end
