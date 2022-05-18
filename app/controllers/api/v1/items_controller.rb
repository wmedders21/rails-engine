class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    item = Item.find_by_id(params[:id])
    if item
      render json: ItemSerializer.new(item)
    else
      render json: { status: "Not Found", code: 404, message: 'item not found' }, status: 404
    end
  end

  def create
    new_item = Item.create(item_params)
    render json: ItemSerializer.new(new_item), status: 201
  end

  def update
    item = Item.find_by_id(params[:id])
    item.update(item_params)
    render json: ItemSerializer.new(item)
  end

  def destroy
    item = Item.find_by_id(params[:id])
    invoices = Invoice.find_by_item_id(item.id)
    invoices.each do |invoice|
      if invoice.items.count == 1
        invoice.destroy
      end
    end
    item.destroy
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
