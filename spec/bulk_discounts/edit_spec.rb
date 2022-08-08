require 'rails_helper'

RSpec.describe "Bulk Discount Edit Page", type: :feature do 

  it "has a link on the bulk discount show page to edit the bulk discount" do 
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

    visit "/merchants/#{merchant1.id}/bulk_discounts/#{discount1.id}"

    expect(page).to have_content("Percentage Discount: 20%")
    expect(page).to have_content("Quantity Threshold: 10")
    expect(page).to have_link('Edit Bulk Discount') 
    
    click_on ('Edit Bulk Discount')
    expect(current_path).to eq("/bulk_discounts/#{discount1.id}/edit")

    fill_in 'percentage', with: '15'
    fill_in 'quantity_threshold', with: '25'
    click_on ('Submit')

    expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts/#{discount1.id}")
    expect(page).to have_content("Percentage Discount: 15%")
    expect(page).to have_content("Quantity Threshold: 25")

    visit "/merchants/#{merchant3.id}/bulk_discounts/#{discount8.id}"

    expect(page).to have_content("Percentage Discount: 10%")
    expect(page).to have_content("Quantity Threshold: 15")
    expect(page).to have_link('Edit Bulk Discount') 
    
    click_on ('Edit Bulk Discount')
    expect(current_path).to eq("/bulk_discounts/#{discount8.id}/edit")

    fill_in 'percentage', with: '25'
    fill_in 'quantity_threshold', with: '45'
    click_on ('Submit')

    expect(current_path).to eq("/merchants/#{merchant3.id}/bulk_discounts/#{discount8.id}")
    expect(page).to have_content("Percentage Discount: 25%")
    expect(page).to have_content("Quantity Threshold: 45")
  end
end