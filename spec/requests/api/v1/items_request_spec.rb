require 'rails_helper'

RSpec.describe 'the item API' do
  it 'sends all items' do
    merchant = create(:merchant)
    items = create_list(:item, 10, merchant_id: merchant.id)

    get '/api/v1/items'

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response).to be_successful
    expect(items).to be_a(Array)
    expect(items.count).to eq(10)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it 'sends one item' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}"

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(response).to be_successful
    expect(item).to be_a(Hash)

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(String)

    expect(item).to have_key(:type)
    expect(item[:id]).to be_a(String)

    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_a(Hash)

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)
  end

  it 'creates an item' do
    merchant = create(:merchant)
    item_params = { name: 'Picture Frame', description: '4x6', unit_price: 3.23, merchant_id: merchant.id}
    headers = { "CONTENT_TYPE" => "application/json" }

    post '/api/v1/items', headers: headers, params: JSON.generate(item_params)

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(response).to be_successful
    expect(item).to be_a(Hash)

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(String)

    expect(item).to have_key(:type)
    expect(item[:id]).to be_a(String)

    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_a(Hash)

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)
  end

  it 'sends an updated item' do
    merchant = create(:merchant)
    seller = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    item_params = { name: 'Chinese Lantern', description: 'Red paper', unit_price: 41.99, merchant_id: seller.id}
    headers = { "CONTENT_TYPE" => "application/json" }

    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item_params)

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(response).to be_successful
    expect(item).to be_a(Hash)

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(String)

    expect(item).to have_key(:type)
    expect(item[:id]).to be_a(String)

    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_a(Hash)

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to eq('Chinese Lantern')

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to eq('Red paper')

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to eq(41.99)

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to eq(seller.id)
  end

  it 'destroy item' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    delete "/api/v1/items/#{item.id}"

    expect(response.status).to eq(204)
    expect(response.body).to eq("")
  end

  it 'destroy invoice if this was the only item on invoice' do
    merchant = create(:merchant)
    customer = Customer.create(first_name: "Willy", last_name: "Wonka")
    item_1 = create(:item, merchant_id: merchant.id)
    item_2 = create(:item, merchant_id: merchant.id)
    #invoice_1 has only 1 item: item_1
    invoice_1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: 'shipped')
    #invoice_2 has 2 items: both item_1 and item_2
    invoice_2 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: 'shipped')
    InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price)
    InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_1.unit_price)
    InvoiceItem.create(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_2.unit_price)

    expect(Invoice.all.count).to eq(2)

    delete "/api/v1/items/#{item_1.id}"

    expect(Invoice.all.count).to eq(1)
  end

  it 'sends the merchant assocaited with an item' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    item = create(:item, merchant_id: merchant_1.id)

    get "/api/v1/items/#{item.id}/merchant"
    response_body = JSON.parse(response.body, symbolize_names: true)

    merchant = response_body[:data]

    expect(response).to be_successful
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(merchant_1.id.to_s)

    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to eq('merchant')

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to eq(merchant_1.name)
  end

  it 'sends error code if item not found' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id, id: 5)

    get "/api/v1/items/6"

    expect(response.status).to eq(404)

    get "/api/v1/items/6/merchant"

    expect(response.status).to eq(404)    
  end
end
