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

    def get_max_discount
        # bulk_discounts.order("percentage desc").first
        bulk_discounts.where('bulk_discounts.quantity_threshold <= ?', quantity)
        .order(percentage: :desc)
        .first   
    end
end


