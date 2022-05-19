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
end
