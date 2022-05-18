require 'rails_helper'

RSpec.describe 'The merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]

    expect(response).to be_successful
    expect(merchants).to be_an(Array)
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'sends one merchant' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(response).to be_successful
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)

    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to be_a(String)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end

  it 'lists all the items belonging to a merchant' do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    item_2 = create(:item, merchant_id: merchant.id)
    item_3 = create(:item, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response).to be_successful
    expect(items).to be_an(Array)
    expect(items.length).to eq(3)

    items.each do |item|

      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)

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
end
