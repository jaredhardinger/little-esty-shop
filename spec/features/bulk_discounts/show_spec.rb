require 'rails_helper'

RSpec.describe 'Bulk discounts show page' do

  it "can show you the attributes of a discount on the show page" do
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

    visit "/merchants/#{merchant1.id}/bulk_discounts/#{discount1.id}"

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

    visit "/merchants/#{merchant1.id}/bulk_discounts/#{discount2.id}"

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

    visit "/merchants/#{merchant2.id}/bulk_discounts/#{discount3.id}"

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

    visit "/merchants/#{merchant3.id}/bulk_discounts/#{discount4.id}"

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

  it "can edit a merchants discount" do
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

    visit "/merchants/#{merchant1.id}/bulk_discounts/#{discount1.id}"

    within "div#discount" do
      # save_and_open_page
      expect(page).to have_link('Edit')
      click_link('Edit')
      expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts/#{discount1.id}/edit")
    end
    # save_and_open_page

    fill_in :discount_percentage, with: 50
    click_on('Submit')
    # save_and_open_page

    expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts/#{discount1.id}")
    expect(page).to have_content("Discount: 50%")
    expect(page).to have_content("Item Quantity: 10")
    expect(page).to_not have_content("Discount: 20%")

    click_link('Edit')
    expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts/#{discount1.id}/edit")
    fill_in :quantity, with: 15
    click_on('Submit')
    expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts/#{discount1.id}")
    expect(page).to have_content("Discount: 50%")
    expect(page).to have_content("Item Quantity: 15")
  end


end
