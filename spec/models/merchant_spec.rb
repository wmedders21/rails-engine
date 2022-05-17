require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it 'relationships' do
    should { have_many(:items) }
    should { have_many(:invoice_items).throught(:items) }
    should { have_many(:invoices).through(:invoice_items) }
    should { have_many(:transactions.through(:invoices) }
    should { have_many(:customers.through(:invoices) }
  end

  it 'validations' do
    should { validate_presence_of(:name) }
  end
end
