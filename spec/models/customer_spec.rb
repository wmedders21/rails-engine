require 'rails_helper'

RSpec.describe Customer, type: :model do
  it 'relationships' do
    should { have_many(:invoices) }
    should { have_many(:transactions).through(:invoices) }
    should { have_many(:invoice_items).through(:invoices) }
    should { have_many(:items).through(:invoice_items) }
    should { have_many(:merchants).through(:items) }
  end

  it 'validations' do
    should { validate_presence_of(:first_name) }
    should { validate_presence_of(:last_name) }
  end
end
