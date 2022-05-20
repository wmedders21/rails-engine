require 'rails_helper'

RSpec.describe 'the merchant search api' do
  it 'sends a single merchant which matches a search term' do
    merchant_1 = create(:merchant, name: "Turing")
    merchant_2 = create(:merchant, name: "Ring World")
    merchant_3 = create(:merchant, name: "Behringer")

    get '/api/v1/merchants/find?name=ring'

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(response.status).to eq(200)
    expect(merchant).to be_a(Hash)
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)

    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to eq('merchant')

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to eq('Behringer')
  end

  it 'sends all merchants which match a search term' do
    merchant_1 = create(:merchant, name: "Turing")
    merchant_2 = create(:merchant, name: "Ring World")
    merchant_3 = create(:merchant, name: "Wally World")

    get '/api/v1/merchants/find_all?name=ring'

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]

    expect(response.status).to eq(200)
    expect(merchants).to be_a(Array)
    expect(merchants.count).to eq(2)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'sends an error' do
    merchant_1 = create(:merchant, name: 'Turing')
    merchant_2 = create(:merchant, name: 'Ring World')
    merchant_3 = create(:merchant, name: 'Behringer')

    get '/api/v1/merchants/find'
    expect(response.status).to eq(400)

    get '/api/v1/merchants/find?name='
    expect(response.status).to eq(400)

    get '/api/v1/merchants/find?name=garbagepeople'
    expect(response.status).to eq(400)

    get '/api/v1/merchants/find_all'
    expect(response.status).to eq(400)

    get '/api/v1/merchants/find_all?name='
    expect(response.status).to eq(400)
  end
end
