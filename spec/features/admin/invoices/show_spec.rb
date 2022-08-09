require 'rails_helper'

RSpec.describe 'Admin Invoices Item Index' do
  describe 'As an Invoice' do
    describe 'When I visit the admin Invoices Show page' do

      it "is able to list all of the invoices atrributes " do

        merchant1 = Merchant.create!(name: "Poke Retirement homes")
        merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
        merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

        item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
        item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant1.id)
        item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant2.id)

        customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id)
        transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)
        invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item2.id, invoice_id: invoice1.id)
        invoice_item3 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item3.id, invoice_id: invoice2.id)

        visit "/admin/invoices/#{invoice1.id}"

        expect(page).to have_content("Pikachu pics")
        expect(page).to have_content(1)
        expect(page).to have_content(1000)
        expect(page).to have_content("shipped")

      end

      it "is able to list all of the invoices atrributes " do

        merchant1 = Merchant.create!(name: "Poke Retirement homes")
        merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
        merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

        item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
        item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant1.id)
        item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant2.id)

        customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id)
        transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)
        invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item2.id, invoice_id: invoice1.id)
        invoice_item3 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item3.id, invoice_id: invoice2.id)

        visit "/admin/invoices/#{invoice2.id}"

        expect(page).to have_content("Junk")
        expect(page).to have_content(1)
        expect(page).to have_content(1000)
        expect(page).to have_content("shipped")

      end

      it "is able to list all of the invoices total Revenue " do

        merchant1 = Merchant.create!(name: "Poke Retirement homes")
        merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
        merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

        item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
        item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant1.id)
        item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant2.id)

        customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id)
        transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)
        invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item2.id, invoice_id: invoice1.id)
        invoice_item3 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item3.id, invoice_id: invoice2.id)

        visit "/admin/invoices/#{invoice2.id}"
        expect(page).to have_content("Junk")
        expect(page).to have_content(1)
        expect(page).to have_content(1000)
        expect(page).to have_content("shipped")
        expect(page).to have_content("Total revenue: 1000")
        expect(page).to_not have_content("Total revenue: 2000")

      end

      it "is able to list all of the invoices total revenue " do

        merchant1 = Merchant.create!(name: "Poke Retirement homes")
        merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
        merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

        item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
        item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant1.id)
        item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant2.id)

        customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id)
        transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)
        invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item2.id, invoice_id: invoice1.id)
        invoice_item3 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item3.id, invoice_id: invoice2.id)

        visit "/admin/invoices/#{invoice1.id}"

        expect(page).to have_content("Pikachu pics")
        expect(page).to have_content(1)
        expect(page).to have_content(1000)
        expect(page).to have_content("shipped")
        expect(page).to have_content("Total revenue: 2000")
        expect(page).to_not have_content("Total revenue: 1000")
      end


      it "is able to list all of the invoices atrributes " do

        merchant1 = Merchant.create!(name: "Poke Retirement homes")
        merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
        merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

        item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
        item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant1.id)
        item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant2.id)

        customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
        invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id)
        transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)
        invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item2.id, invoice_id: invoice1.id)
        invoice_item3 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item3.id, invoice_id: invoice2.id)

        visit "/admin/invoices/#{invoice1.id}"

        expect(page).to have_content('completed')

        select "in progress", :from => "Status"
        click_on 'Update Invoice'

        expect(page).to have_content('completed')
      end

      it "can list the total revenue with and without bulk discounts for an invoice" do 
        merchant1 = Merchant.create!(name: "Poke Retirement homes")
        item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
        item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 3000, merchant_id: merchant1.id)
        customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
        invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
        bulk_discount1 = BulkDiscount.create!(quantity_threshold: 10, percentage: 10, merchant_id: merchant1.id)

        invoice_item1 = InvoiceItem.create!(quantity: 10, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
        invoice_item2 = InvoiceItem.create!(quantity: 5, unit_price: item2.unit_price, status: "shipped", item_id: item2.id, invoice_id: invoice1.id)
        transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)

        visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"

        expect(page).to have_content("Total revenue: 25000")
        expect(page).to_not have_content("Total revenue: 1000")
        expect(page).to have_content("Total revenue with bulk discount: 24000") 
      end
    end
  end
end
