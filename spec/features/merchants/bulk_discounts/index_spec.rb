require 'rails_helper'

RSpec.describe "Merchant's Bulk Discounts Index", type: :feature do 

  it "US1: has a link to view all discounts on a merchant's dashboard" do 
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
	  merchant2 = Merchant.create!(name: "Rendolyn Guiz's poke stops")
	  merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("#{merchant1.name}")
    expect(page).to_not have_content("#{merchant2.name}")
    expect(page).to_not have_content("#{merchant3.name}")

    expect(page).to have_link('View all discounts')
    click_on 'View all discounts'
    expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts") 

    visit "/merchants/#{merchant2.id}/dashboard"

    expect(page).to have_content("#{merchant2.name}")
    expect(page).to_not have_content("#{merchant3.name}")
    expect(page).to_not have_content("#{merchant1.name}")

    expect(page).to have_link('View all discounts')
    click_on 'View all discounts'
    expect(current_path).to eq("/merchants/#{merchant2.id}/bulk_discounts")

    visit "/merchants/#{merchant3.id}/dashboard"

    expect(page).to have_content("#{merchant3.name}")
    expect(page).to_not have_content("#{merchant2.name}")
    expect(page).to_not have_content("#{merchant1.name}")

    expect(page).to have_link('View all discounts')
    click_on 'View all discounts'
    expect(current_path).to eq("/merchants/#{merchant3.id}/bulk_discounts")
  end

  it "US1: can list all bulk discounts on the index page including percentage discount and quantity threshold" do 
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
    discount1 = BulkDiscount.create!(percentage: 20, quantity_threshold: 10, merchant_id: merchant1.id)
    discount2 = BulkDiscount.create!(percentage: 25, quantity_threshold: 15, merchant_id: merchant1.id)
    discount3 = BulkDiscount.create!(percentage: 30, quantity_threshold: 20, merchant_id: merchant1.id)

    merchant2 = Merchant.create!(name: "Rendolyn Guiz's poke stops")
    discount4 = BulkDiscount.create!(percentage: 10, quantity_threshold: 10, merchant_id: merchant2.id)
    discount5 = BulkDiscount.create!(percentage: 15, quantity_threshold: 15, merchant_id: merchant2.id)
    discount6 = BulkDiscount.create!(percentage: 20, quantity_threshold: 20, merchant_id: merchant2.id)

    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")
    discount7 = BulkDiscount.create!(percentage: 5, quantity_threshold: 10, merchant_id: merchant3.id)
    discount8 = BulkDiscount.create!(percentage: 10, quantity_threshold: 15, merchant_id: merchant3.id)
    discount9 = BulkDiscount.create!(percentage: 15, quantity_threshold: 20, merchant_id: merchant3.id)

    visit "/merchants/#{merchant1.id}/bulk_discounts"
    
    expect(page).to have_content("Poke Retirement homes")
    expect(page).to_not have_content("Rendolyn Guiz's poke stops")
    expect(page).to have_content("Percentage Discount: 20%")
    expect(page).to have_content("Quantity Threshold: 10")
    expect(page).to have_content("Percentage Discount: 25%")
    expect(page).to have_content("Quantity Threshold: 15")
    expect(page).to have_content("Percentage Discount: 30%")
    expect(page).to have_content("Quantity Threshold: 20")
    expect(page).to_not have_content("Percentage Discount: 10%")
    expect(page).to_not have_content("Quantity Threshold: 25")

    visit "/merchants/#{merchant2.id}/bulk_discounts"
    
    expect(page).to have_content("Rendolyn Guiz's poke stops")
    expect(page).to_not have_content("Poke Retirement homes")
    expect(page).to have_content("Percentage Discount: 10%")
    expect(page).to have_content("Quantity Threshold: 10")
    expect(page).to have_content("Percentage Discount: 15%")
    expect(page).to have_content("Quantity Threshold: 15")
    expect(page).to have_content("Percentage Discount: 20%")
    expect(page).to have_content("Quantity Threshold: 20")
    expect(page).to_not have_content("Percentage Discount: 30%")
    expect(page).to_not have_content("Quantity Threshold: 25")

    visit "/merchants/#{merchant3.id}/bulk_discounts"
    
    expect(page).to have_content("Dhirley Secasrio's knits and bits")
    expect(page).to_not have_content("Rendolyn Guiz's poke stops")
    expect(page).to have_content("Percentage Discount: 5%")
    expect(page).to have_content("Quantity Threshold: 10")
    expect(page).to have_content("Percentage Discount: 10%")
    expect(page).to have_content("Quantity Threshold: 15")
    expect(page).to have_content("Percentage Discount: 15%")
    expect(page).to have_content("Quantity Threshold: 20")
    expect(page).to_not have_content("Percentage Discount: 30%")
    expect(page).to_not have_content("Quantity Threshold: 25")
  end

  it "US1: each bulk discount listed has a link to its show page" do 
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
    discount1 = BulkDiscount.create!(percentage: 20, quantity_threshold: 10, merchant_id: merchant1.id)
    discount2 = BulkDiscount.create!(percentage: 25, quantity_threshold: 15, merchant_id: merchant1.id)
    discount3 = BulkDiscount.create!(percentage: 30, quantity_threshold: 20, merchant_id: merchant1.id)

    merchant2 = Merchant.create!(name: "Rendolyn Guiz's poke stops")
    discount4 = BulkDiscount.create!(percentage: 10, quantity_threshold: 10, merchant_id: merchant2.id)
    discount5 = BulkDiscount.create!(percentage: 15, quantity_threshold: 15, merchant_id: merchant2.id)
    discount6 = BulkDiscount.create!(percentage: 20, quantity_threshold: 20, merchant_id: merchant2.id)

    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")
    discount7 = BulkDiscount.create!(percentage: 5, quantity_threshold: 10, merchant_id: merchant3.id)
    discount8 = BulkDiscount.create!(percentage: 10, quantity_threshold: 15, merchant_id: merchant3.id)
    discount9 = BulkDiscount.create!(percentage: 15, quantity_threshold: 20, merchant_id: merchant3.id)

    visit "/merchants/#{merchant1.id}/bulk_discounts"
    expect(page).to have_content("Poke Retirement homes")

    within "div#discount-#{discount1.id}" do
      expect(page).to have_content("Percentage Discount: 20%")
      expect(page).to have_content("Quantity Threshold: 10")
      expect(page).to have_link('Bulk Discount Page') 
    end

    within "div#discount-#{discount2.id}" do
      expect(page).to have_content("Percentage Discount: 25%")
      expect(page).to have_content("Quantity Threshold: 15")
      expect(page).to have_link('Bulk Discount Page')
    end 

    within "div#discount-#{discount3.id}" do
      expect(page).to have_content("Percentage Discount: 30%")
      expect(page).to have_content("Quantity Threshold: 20")
      expect(page).to have_link('Bulk Discount Page')
    end

    visit "/merchants/#{merchant2.id}/bulk_discounts"
    expect(page).to have_content("Rendolyn Guiz's poke stops")

    within "div#discount-#{discount4.id}" do
      expect(page).to have_content("Percentage Discount: 10%")
      expect(page).to have_content("Quantity Threshold: 10")
      expect(page).to have_link('Bulk Discount Page')
    end

    within "div#discount-#{discount5.id}" do
      expect(page).to have_content("Percentage Discount: 15%")
      expect(page).to have_content("Quantity Threshold: 15")
      expect(page).to have_link('Bulk Discount Page')
    end 

    within "div#discount-#{discount6.id}" do
      expect(page).to have_content("Percentage Discount: 20%")
      expect(page).to have_content("Quantity Threshold: 20")
      expect(page).to have_link('Bulk Discount Page')
    end

    visit "/merchants/#{merchant3.id}/bulk_discounts"
    expect(page).to have_content("Dhirley Secasrio's knits and bits")

    within "div#discount-#{discount7.id}" do
      expect(page).to have_content("Percentage Discount: 5%")
      expect(page).to have_content("Quantity Threshold: 10")
      expect(page).to have_link('Bulk Discount Page')
    end

    within "div#discount-#{discount8.id}" do
      expect(page).to have_content("Percentage Discount: 10%")
      expect(page).to have_content("Quantity Threshold: 15")
      expect(page).to have_link('Bulk Discount Page')
    end

    within "div#discount-#{discount9.id}" do
      expect(page).to have_content("Percentage Discount: 15%")
      expect(page).to have_content("Quantity Threshold: 20")
      expect(page).to have_link('Bulk Discount Page')
    end
  end
end