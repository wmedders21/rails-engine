require 'rails_helper'

RSpec.describe 'the item search api' do
  it 'sends a single object from a name search' do
    merchant = create(:merchant)
    items = create_list(:item, 10, merchant_id: merchant.id)
    control_item_1 = Item.create!(name: 'Turing', description: "zzz", unit_price: 112, merchant_id: merchant.id)
    control_item_2 = Item.create!(name: 'Ring World', description: "xxx", unit_price: 10, merchant_id: merchant.id)
    items << control_item_1
    items << control_item_2

    get '/api/v1/items/find?name=ring'

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
    expect(item[:attributes][:name]).to eq('Ring World')

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)
  end
end
