class Invoice < ApplicationRecord
  enum status:[:'in progress', :cancelled, :completed]

  belongs_to :customer

  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  validates_presence_of :status

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def self.incomplete_invoices
    joins(:invoice_items)
    .where.not('invoice_items.status = ?', 2)
    .distinct
    .order(:created_at)
  end

  def revenue_with_discount
    invoice_items.joins(:bulk_discounts)
    .select("invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * (bulk_discounts.percentage / 100.00)) AS discount")
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .group("invoice_items.id")
    .sum(&:discount).to_i
  end

  def discounted_revenue
    total_revenue - revenue_with_discount
  end 
end

 

 
