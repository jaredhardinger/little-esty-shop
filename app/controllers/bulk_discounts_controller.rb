class BulkDiscountsController < ApplicationController

  def show 
    @discount = BulkDiscount.find(params[:bulk_discount_id])
  end

end