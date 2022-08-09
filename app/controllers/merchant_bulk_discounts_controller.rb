class MerchantBulkDiscountsController < ApplicationController

  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = HolidayFacade.new
  end

  def show
    @discount = BulkDiscount.find(params[:bulk_discount_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
   bulk_discount = BulkDiscount.new(bulk_discount_params)
    if bulk_discount.save 
      redirect_to "/merchants/#{params[:merchant_id]}/bulk_discounts"
    else  
      flash[:alert] = "Error: #{(bulk_discount.errors)}"
      redirect_to "/merchants/#{params[:merchant_id]}/bulk_discounts/new"
    end
  end

  def destroy 
    bulk_discount = BulkDiscount.find(params[:bulk_discount_id])
    bulk_discount.destroy
    redirect_to "/merchants/#{params[:merchant_id]}/bulk_discounts"
  end

  private 
  def bulk_discount_params
    params.permit(:percentage, :quantity_threshold, :merchant_id)
  end
end
