class Api::V1::Items::SearchController < ApplicationController

  def index
    if search_params.include?(:name) && !search_params[:name].empty?
      items = Item.name_search(name_search_params)
      render json: ItemSerializer.new(items)
    else
      render json: ErrorSerializer.format_error, status: 400
    end
  end

  def show
    if search_params[:min_price].to_i > 0 && search_params[:max_price].to_i > 0 && search_params.keys.count == 2
      if search_params[:min_price].to_i < search_params[:max_price].to_i
        item = Item.price_range_search(search_params[:min_price].to_i, search_params[:max_price].to_i).first
        render json: ItemSerializer.new(item)
      else
        render json: ErrorSerializer.format_error, status: 400
      end
    elsif search_params[:min_price].to_i > 0 && search_params.keys.count == 1
      item = Item.min_price_search(price_search_params[:min_price].to_i).first
      if item
        render json: ItemSerializer.new(item)
      else
        render json: ErrorSerializer.format_error, status: 400
      end
    elsif search_params[:max_price].to_i > 0 && search_params.keys.count == 1
      item = Item.max_price_search(price_search_params[:max_price].to_i).first
      render json: ItemSerializer.new(item)
    elsif search_params.include?(:name) && search_params[:name].empty? == false && search_params.keys.count == 1
        item = Item.name_search(name_search_params).first
        if item
          render json: ItemSerializer.new(item)
        else
          render json: ErrorSerializer.format_error, status: 400
        end
    else
      render json: ErrorSerializer.value_error, status: 400
    end
  end

  private

  def search_params
    params.permit(:name, :min_price, :max_price)
  end

  def name_search_params
    params.require(:name)
  end

  def price_search_params
    params.permit(:min_price, :max_price)
  end
end
