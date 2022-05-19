class Api::V1::Items::SearchController < ApplicationController

  def show
    if search_params.include?(:name) && search_params[:name]
      item = Item.name_search(search_params[:name]).first
      render json: ItemSerializer.new(item)
    elsif search_params.include?(:min_price) && search_params.include?(:min_price) && search_params[:min_price] && search_params[:max_price]

    elsif search_params.include?(:min_price) && search_params[:min_price]
      item = Item.min_price_search(search_params[:min_price].to_i).first
      render json: ItemSerializer.new(item)
    elsif search_params.include?(:max_price) && search_params[:max_price]
      item = Item.max_price_search(search_params[:max_price].to_i).first
      render json: ItemSerializer.new(item)
    else

    end
  end



  private

  def search_params
    params.permit(:name, :min_price, :max_price)
  end
end
