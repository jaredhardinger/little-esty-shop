class Invoice < ApplicationRecord
  enum status:[:'in progress', :cancelled, :completed]

  belongs_to :customer

  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  validates_presence_of :status

  def total_revenue(merchant_id)
    invoice_items
    .joins(:item)
    .where(items: { merchant_id: merchant_id })
    .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def self.incomplete_invoices
    joins(:invoice_items)
    .where.not('invoice_items.status = ?', 2)
    .distinct
    .order(:created_at)
  end

  def discounted_revenue(merchant_id)
    if bulk_discounts
      invoice_items.joins(item: :merchant)
      .where(merchants:{ id: merchant_id })
      .sum(&:discounted_revenue)
    end
  end

  def invoice_discount_revenue
    invoice_items.joins(:item).sum(&:discounted_revenue).to_i
  end
end
