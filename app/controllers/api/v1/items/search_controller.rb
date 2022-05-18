class Api::V1::Items::SearchController < ApplicationController

  def show
    if search_params.include?(:name) && search_params[:name]
      item = Item.name_search(search_params[:name]).first
      render json: ItemSerializer.new(item)
    end
  end



  private

  def search_params
    params.permit(:name, :min_price, :max_price)
  end
end
