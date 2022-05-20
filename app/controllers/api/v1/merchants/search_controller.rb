class Api::V1::Merchants::SearchController < ApplicationController

  def index
    if search_params.include?(:name) && !search_params[:name].empty?
      merchants = Merchant.name_search(search_params[:name])
      if merchants
        render json: MerchantSerializer.new(merchants)
      else
        render json: ErrorSerializer.format_error, status: 400
      end
    else
      render json: ErrorSerializer.format_error, status: 400
    end
  end

  def show
    if search_params.include?(:name) && !search_params[:name].empty?
      merchant = Merchant.name_search(search_params[:name]).first
      if merchant
        render json: MerchantSerializer.new(merchant)
      else
        render json: ErrorSerializer.format_error, status: 400
      end
    else
      render json: ErrorSerializer.format_error, status: 400
    end
  end

  private
  def search_params
    params.permit(:name)
  end
end
