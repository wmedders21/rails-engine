require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'relationships' do
    should { belong_to(:invoices) }
  end

  it 'validations' do
    should { validate_presence_of(:invoice_id) }
    should { validate_presence_of(:credit_card_number) }
    should { validate_presence_of(:credit_card_expiration_date) }
    should { validate_presence_of(:result) }
  end
end
