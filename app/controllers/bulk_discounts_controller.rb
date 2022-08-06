class BulkDiscountsController < ApplicationController

  def index
    @discounts = Merchant.find(params[:merchant_id]).bulk_discounts
  end

  def show
    @discount = BulkDiscount.find(params[:discount_id])
  end

end
