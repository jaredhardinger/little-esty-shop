class BulkDiscountsController < ApplicationController

  def index
    @discounts = Merchant.find(params[:merchant_id]).bulk_discounts
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = HolidayFacade.new
  end

  def show
    @discount = BulkDiscount.find(params[:discount_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.bulk_discounts.create!(bulk_discount_params)
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  def delete
    merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:discount_id])
    discount.destroy
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  def edit
    @discount = BulkDiscount.find(params[:discount_id])
  end

  def update
    discount = BulkDiscount.find(params[:discount_id])
    discount.update!(bulk_discount_params)
    redirect_to "/merchants/#{discount.merchant.id}/bulk_discounts/#{discount.id}"
  end

  private
  def bulk_discount_params
    params.permit(:merchant_id, :discount_percentage, :quantity)
  end
end
