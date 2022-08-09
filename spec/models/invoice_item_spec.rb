require 'rails_helper'

RSpec.describe InvoiceItem do

  describe 'enums' do
    it 'does' do 
      expect { define_enum_for(:status).with_values(['pending', 'packaged', 'shipped']) }
    end
  end

  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_many(:bulk_discounts).through(:merchant)}
  end

  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end

  describe 'instance methods' do 
    
    it "can get the best bulk discount from a merchant" do 
            merchant1 = Merchant.create!(name: "Poke Retirement homes")

      item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
      item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 3000, merchant_id: merchant1.id)
      item3 = Item.create!(name: "Stickers", description: 'Pikachu sticker', unit_price: 100, merchant_id: merchant1.id)
      item4 = Item.create!(name: "Button", description: 'Pikachu button', unit_price: 100, merchant_id: merchant1.id)

      customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")

      invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
      invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id)
      invoice3 = Invoice.create!(status: "completed", customer_id: customer1.id)

      bulk_discount1 = BulkDiscount.create!(quantity_threshold: 10, percentage: 10, merchant_id: merchant1.id)
      bulk_discount2 = BulkDiscount.create!(quantity_threshold: 5, percentage: 15, merchant_id: merchant1.id)

      invoice_item1 = InvoiceItem.create!(quantity: 10, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
      invoice_item2 = InvoiceItem.create!(quantity: 5, unit_price: item2.unit_price, status: "shipped", item_id: item2.id, invoice_id: invoice2.id)
      invoice_item3 = InvoiceItem.create!(quantity: 12, unit_price: item3.unit_price, status: "shipped", item_id: item3.id, invoice_id: invoice3.id)
      
      transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)
      transaction2 = Transaction.create!(credit_card_number: "123456789144456789", result: "success", invoice_id: invoice2.id)
      transaction3 = Transaction.create!(credit_card_number: "123456745123456789", result: "success", invoice_id: invoice3.id)

      expect(invoice_item1.get_max_discount).to eq(bulk_discount2)
      expect(invoice_item2.get_max_discount).to eq(bulk_discount2)
      expect(invoice_item3.get_max_discount).to eq(bulk_discount2)     
    end
  end
end