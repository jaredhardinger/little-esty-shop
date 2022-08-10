class InvoiceItem < ApplicationRecord
    enum status:[:pending, :packaged, :shipped]

    belongs_to :invoice
    belongs_to :item

    has_one :merchant, through: :item
    has_many :transactions, through: :invoice
    has_many :bulk_discounts, through: :merchant
    validates_presence_of :quantity
    validates_presence_of :unit_price
    validates_presence_of :status

    def best_discount
      bulk_discounts.where("#{quantity} >= quantity")
      .select('bulk_discounts.*')
      .group('bulk_discounts.id, merchants.id, items.id')
      .order(discount_percentage: :desc)
      .first
    end

    def discounted_revenue
      if best_discount
        (1 - best_discount.discount_percentage.to_f / 100) * (quantity * unit_price)
      else
        total_revenue
      end
    end

    def total_revenue
      (quantity * unit_price)
    end
end
