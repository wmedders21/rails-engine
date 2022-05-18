class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find_by_id(params[:id]))
  end

  def create
    new_item = Item.create(item_params)
    render json: ItemSerializer.new(new_item)
  end

  def update
    item = Item.find_by_id(params[:id])
    item.update(item_params)
    render json: ItemSerializer.new(item)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
