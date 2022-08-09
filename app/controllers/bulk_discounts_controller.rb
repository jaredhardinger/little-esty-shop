class BulkDiscountsController < ApplicationController

  def index 
    @merchant = Merchant.find(params[:id]) 
  end

  def edit 
    @discount = BulkDiscount.find(params[:bulk_discount_id])
  end
  
  def update 
    discount = BulkDiscount.find(params[:bulk_discount_id])
    discount.update(bulk_discount_params)
    redirect_to "/merchants/#{discount.merchant_id}/bulk_discounts/#{discount.id}"
  end
end

private 
  def bulk_discount_params
    params.permit(:percentage, :quantity_threshold, :merchant_id)
  end