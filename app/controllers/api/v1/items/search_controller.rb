class Api::V1::Items::SearchController < ApplicationController

  def show
    # if search_params.include?(:min_price) && search_params.include?(:min_price) && search_params[:min_price] && search_params[:max_price]
    #   item = Item.price_range_search(search_params[:min_price].to_i, search_params[:max_price].to_i).first
    #   render json: ItemSerializer.new(item)
    # elsif search_params.include?(:min_price) && search_params[:min_price].to_i >= 0 && !search_params.include?(:name)
    #   item = Item.min_price_search(search_params[:min_price].to_i).first
    #   render json: ItemSerializer.new(item)
    # elsif search_params.include?(:max_price) && search_params[:max_price] && !search_params.include?(:name)
    #   item = Item.max_price_search(search_params[:max_price].to_i).first
    #   render json: ItemSerializer.new(item)
    # elsif search_params.include?(:name) && search_params[:name]
    #     item = Item.name_search(search_params[:name]).first
    #     render json: ItemSerializer.new(item)
    # else
    #   render status: 400
    # end

    if search_params.include?(:min_price) && search_params.include?(:max_price) && search_params[:min_price].to_i >= 0 && search_params[:max_price].to_i >= 0 && !search_params.include?(:name)
      item = Item.price_range_search(search_params[:min_price].to_i, search_params[:max_price].to_i).first
      render json: ItemSerializer.new(item)
    elsif search_params.include?(:min_price) && search_params[:min_price].to_i >= 0 && !search_params.include?(:name) && !search_params.include?(:max_price)
      item = Item.min_price_search(search_params[:min_price].to_i).first
      render json: ItemSerializer.new(item)
    elsif search_params.include?(:max_price) && search_params[:max_price].to_i >= 0 && !search_params.include?(:name) && !search_params.include?(:min_price)
      item = Item.max_price_search(search_params[:max_price].to_i).first
      render json: ItemSerializer.new(item)
    elsif search_params.include?(:name) && search_params[:name]
        item = Item.name_search(search_params[:name]).first
        render json: ItemSerializer.new(item)
    else
      render json: { error: "bad request" }, status: 400
    end
  end

  private

  def search_params
    params.permit(:name, :min_price, :max_price)
  end

  # def name_search_params
  #   params.permit(:name)
  # end
  #
  # def price_search_params
  #   params.permit(:min_price, :max_price)
  # end
end
