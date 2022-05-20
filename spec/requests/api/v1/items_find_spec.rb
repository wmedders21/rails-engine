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

  it 'sends a single object for a price search' do
    merchant = create(:merchant)
    item_1 = Item.create!(name: 'Blueberry', description: "xxx", unit_price: 50, merchant_id: merchant.id)
    item_2 = Item.create!(name: 'Apple', description: "zzz", unit_price: 10, merchant_id: merchant.id)
    item_3 = Item.create!(name: 'Danish', description: "www", unit_price: 100, merchant_id: merchant.id)
    item_4 = Item.create!(name: 'Casserole', description: "yyy", unit_price: 150, merchant_id: merchant.id)

    get '/api/v1/items/find?min_price=99'

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
    expect(item[:attributes][:name]).to eq('Casserole')

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)

    get '/api/v1/items/find?max_price=70'

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
    expect(item[:attributes][:name]).to eq('Apple')

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)

    get '/api/v1/items/find?min_price=40&max_price=120'

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
    expect(item[:attributes][:name]).to eq('Blueberry')

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)
  end

  it 'sends all items that match a name search' do
    merchant = create(:merchant)
    item_1 = create(:item, name: 'Turing Shirt', merchant_id: merchant.id)
    item_2 = create(:item, name: 'Ring Binder', merchant_id: merchant.id)
    item_3 = create(:item, name: 'Ice Cream Sammy', merchant_id: merchant.id)

    get '/api/v1/items/find_all?name=ring'

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response).to be_successful
    expect(items).to be_a(Array)
    expect(items.count).to eq(2)

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

  it 'sends an error' do
    merchant = create(:merchant)
    item_1 = create(:item, name: 'Turing Shirt', merchant_id: merchant.id)
    item_2 = create(:item, name: 'Ring Binder', merchant_id: merchant.id)
    item_3 = create(:item, name: 'Ice Cream Sammy', merchant_id: merchant.id)

    get '/api/v1/items/find'
    expect(response.status).to eq(400)

    get '/api/v1/items/find?name='
    expect(response.status).to eq(400)

    get '/api/v1/items/find?name=3453453'
    expect(response.status).to eq(400)

    get '/api/v1/items/find?name=ring&min_price=50'
    expect(response.status).to eq(400)

    get '/api/v1/items/find?name=ring&max_price=50'
    expect(response.status).to eq(400)

    get '/api/v1/items/find?name=ring&min_price=40&max_price=70'
    expect(response.status).to eq(400)

    get '/api/v1/items/find?min_price=70&max_price=40'
    expect(response.status).to eq(400)

    get '/api/v1/items/find_all'
    expect(response.status).to eq(400)

    get '/api/v1/items/find_all?name='
    expect(response.status).to eq(400)
  end
end
