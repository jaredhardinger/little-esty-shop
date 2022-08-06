require 'rails_helper'

RSpec.describe 'Bulk discounts index page' do
  describe 'merchants dashboard/has link to Bulk discount index page/links to discount show page' do
    it "has a link to the discounts that takes you to the bulk discount index page" do
      merchant1 = Merchant.create!(name: "Poke Retirement homes", status: "enabled")
      merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops", status: "enabled")
      merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits", status: "enabled")

      item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
      item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant2.id)
      item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant3.id)

      customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")

      invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
      invoice2 = Invoice.create!(status: "cancelled", customer_id: customer1.id)
      invoice3 = Invoice.create!(status: "in progress", customer_id: customer1.id)

      transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)

      invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
      invoice_item2 = InvoiceItem.create!(quantity: 2, unit_price: item2.unit_price, status: "pending", item_id: item2.id, invoice_id: invoice2.id)
      invoice_item3 = InvoiceItem.create!(quantity: 3, unit_price: item3.unit_price, status: "packaged", item_id: item3.id, invoice_id: invoice3.id)

      discount1 = BulkDiscount.create!(discount_percentage: 20, quantity:10, merchant_id: merchant1.id)
      discount2 = BulkDiscount.create!(discount_percentage: 30, quantity:15, merchant_id: merchant1.id)
      discount3 = BulkDiscount.create!(discount_percentage: 40, quantity:20, merchant_id: merchant2.id)
      discount4 = BulkDiscount.create!(discount_percentage: 50, quantity:5, merchant_id: merchant3.id)

      visit "/merchants/#{merchant1.id}/dashboard"

        expect(page).to have_link("All Discount's")
        click_link ("All Discount's")
        expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts")

      visit "/merchants/#{merchant2.id}/dashboard"

        expect(page).to have_link("All Discount's")
        click_link ("All Discount's")
        expect(current_path).to eq("/merchants/#{merchant2.id}/bulk_discounts")

      visit "/merchants/#{merchant3.id}/dashboard"

        expect(page).to have_link("All Discount's")
        click_link ("All Discount's")
        expect(current_path).to eq("/merchants/#{merchant3.id}/bulk_discounts")
    end

    it "links to the bulk discount index page" do
      merchant1 = Merchant.create!(name: "Poke Retirement homes", status: "enabled")
      merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops", status: "enabled")
      merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits", status: "enabled")

      item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
      item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant2.id)
      item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant3.id)

      customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")

      invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
      invoice2 = Invoice.create!(status: "cancelled", customer_id: customer1.id)
      invoice3 = Invoice.create!(status: "in progress", customer_id: customer1.id)

      transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)

      invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
      invoice_item2 = InvoiceItem.create!(quantity: 2, unit_price: item2.unit_price, status: "pending", item_id: item2.id, invoice_id: invoice2.id)
      invoice_item3 = InvoiceItem.create!(quantity: 3, unit_price: item3.unit_price, status: "packaged", item_id: item3.id, invoice_id: invoice3.id)

      discount1 = BulkDiscount.create!(discount_percentage: 20, quantity:10, merchant_id: merchant1.id)
      discount2 = BulkDiscount.create!(discount_percentage: 30, quantity:15, merchant_id: merchant1.id)
      discount3 = BulkDiscount.create!(discount_percentage: 40, quantity:20, merchant_id: merchant2.id)
      discount4 = BulkDiscount.create!(discount_percentage: 50, quantity:5, merchant_id: merchant3.id)

      visit "/merchants/#{merchant1.id}/bulk_discounts"

      within "div#discounts" do
        expect(page).to have_content("Percentage: #{discount1.discount_percentage}")
        expect(page).to have_content("Quantity: #{discount1.quantity}")
        expect(page).to have_content("Percentage: #{discount2.discount_percentage}")
        expect(page).to have_content("Quantity: #{discount2.quantity}")
        expect(page).to_not have_content("Percentage: #{discount3.discount_percentage}")
        expect(page).to_not have_content("Quantity: #{discount3.quantity}")
        expect(page).to_not have_content("Percentage: #{discount4.discount_percentage}")
        expect(page).to_not have_content("Quantity: #{discount4.quantity}")
      end

      visit "/merchants/#{merchant2.id}/bulk_discounts"

      within "div#discounts" do
        expect(page).to have_content("Percentage: #{discount3.discount_percentage}")
        expect(page).to have_content("Quantity: #{discount3.quantity}")
        expect(page).to_not have_content("Percentage: #{discount1.discount_percentage}")
        expect(page).to_not have_content("Quantity: #{discount1.quantity}")
        expect(page).to_not have_content("Percentage: #{discount2.discount_percentage}")
        expect(page).to_not have_content("Quantity: #{discount2.quantity}")
        expect(page).to_not have_content("Percentage: #{discount4.discount_percentage}")
        expect(page).to_not have_content("Quantity: #{discount4.quantity}")
      end

      visit "/merchants/#{merchant3.id}/bulk_discounts"

      within "div#discounts" do
        expect(page).to have_content("Percentage: #{discount4.discount_percentage}")
        expect(page).to have_content("Quantity: #{discount4.quantity}")
        expect(page).to_not have_content("Percentage: #{discount1.discount_percentage}")
        expect(page).to_not have_content("Quantity: #{discount1.quantity}")
        expect(page).to_not have_content("Percentage: #{discount2.discount_percentage}")
        expect(page).to_not have_content("Quantity: #{discount2.quantity}")
        expect(page).to_not have_content("Percentage: #{discount3.discount_percentage}")
        expect(page).to_not have_content("Quantity: #{discount3.quantity}")
      end
    end

    it "links each discount to its discount show page" do
      merchant1 = Merchant.create!(name: "Poke Retirement homes", status: "enabled")
      merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops", status: "enabled")
      merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits", status: "enabled")

      item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
      item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant2.id)
      item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant3.id)

      customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")

      invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
      invoice2 = Invoice.create!(status: "cancelled", customer_id: customer1.id)
      invoice3 = Invoice.create!(status: "in progress", customer_id: customer1.id)

      transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)

      invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
      invoice_item2 = InvoiceItem.create!(quantity: 2, unit_price: item2.unit_price, status: "pending", item_id: item2.id, invoice_id: invoice2.id)
      invoice_item3 = InvoiceItem.create!(quantity: 3, unit_price: item3.unit_price, status: "packaged", item_id: item3.id, invoice_id: invoice3.id)

      discount1 = BulkDiscount.create!(discount_percentage: 20, quantity:10, merchant_id: merchant1.id)
      discount2 = BulkDiscount.create!(discount_percentage: 30, quantity:15, merchant_id: merchant1.id)
      discount3 = BulkDiscount.create!(discount_percentage: 40, quantity:20, merchant_id: merchant2.id)
      discount4 = BulkDiscount.create!(discount_percentage: 50, quantity:5, merchant_id: merchant3.id)

      visit "/merchants/#{merchant1.id}/bulk_discounts"

      expect(page).to have_link("#{discount1.id}")
      expect(page).to have_link("#{discount2.id}")
      expect(page).to_not have_link("#{discount3.id}")
      expect(page).to_not have_link("#{discount4.id}")

      click_link("#{discount1.id}")
      expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts/#{discount1.id}")

      within "div#discount" do
        expect(page).to have_content("Discount: #{discount1.discount_percentage}%")
        expect(page).to have_content("Item Quantity: #{discount1.quantity}")
        expect(page).to_not have_content("Discount: #{discount2.discount_percentage}%")
        expect(page).to_not have_content("Item Quantity: #{discount2.quantity}")
        expect(page).to_not have_content("Discount: #{discount3.discount_percentage}%")
        expect(page).to_not have_content("Item Quantity: #{discount3.quantity}")
        expect(page).to_not have_content("Discount: #{discount4.discount_percentage}%")
        expect(page).to_not have_content("Item Quantity: #{discount4.quantity}")
      end

      visit "/merchants/#{merchant1.id}/bulk_discounts"
      click_link("#{discount2.id}")
      expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts/#{discount2.id}")

      within "div#discount" do
        expect(page).to have_content("Discount: #{discount2.discount_percentage}%")
        expect(page).to have_content("Item Quantity: #{discount2.quantity}")
        expect(page).to_not have_content("Discount: #{discount1.discount_percentage}%")
        expect(page).to_not have_content("Item Quantity: #{discount1.quantity}")
        expect(page).to_not have_content("Discount: #{discount3.discount_percentage}%")
        expect(page).to_not have_content("Item Quantity: #{discount3.quantity}")
        expect(page).to_not have_content("Discount: #{discount4.discount_percentage}%")
        expect(page).to_not have_content("Item Quantity: #{discount4.quantity}")
      end

      visit "/merchants/#{merchant2.id}/bulk_discounts"
      click_link("#{discount3.id}")
      expect(current_path).to eq("/merchants/#{merchant2.id}/bulk_discounts/#{discount3.id}")

      within "div#discount" do
        expect(page).to have_content("Discount: #{discount3.discount_percentage}%")
        expect(page).to have_content("Item Quantity: #{discount3.quantity}")
        expect(page).to_not have_content("Discount: #{discount1.discount_percentage}%")
        expect(page).to_not have_content("Item Quantity: #{discount1.quantity}")
        expect(page).to_not have_content("Discount: #{discount2.discount_percentage}%")
        expect(page).to_not have_content("Item Quantity: #{discount2.quantity}")
        expect(page).to_not have_content("Discount: #{discount4.discount_percentage}%")
        expect(page).to_not have_content("Item Quantity: #{discount4.quantity}")
      end

      visit "/merchants/#{merchant3.id}/bulk_discounts"
      click_link("#{discount4.id}")
      expect(current_path).to eq("/merchants/#{merchant3.id}/bulk_discounts/#{discount4.id}")

      within "div#discount" do
        expect(page).to have_content("Discount: #{discount4.discount_percentage}%")
        expect(page).to have_content("Item Quantity: #{discount4.quantity}")
        expect(page).to_not have_content("Discount: #{discount1.discount_percentage}%")
        expect(page).to_not have_content("Item Quantity: #{discount1.quantity}")
        expect(page).to_not have_content("Discount: #{discount2.discount_percentage}%")
        expect(page).to_not have_content("Item Quantity: #{discount2.quantity}")
        expect(page).to_not have_content("Discount: #{discount3.discount_percentage}%")
        expect(page).to_not have_content("Item Quantity: #{discount3.quantity}")
      end
    end
  end
end
