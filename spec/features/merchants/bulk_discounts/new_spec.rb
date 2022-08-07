require 'rails_helper'

RSpec.describe "Merchant's Bulk Discounts Create", type: :feature do 

# Merchant Bulk Discount Create

# As a merchant
# When I visit my bulk discounts index
# Then I see a link to create a new discount
# When I click this link
# Then I am taken to a new page where I see a form to add a new bulk discount
# When I fill in the form with valid data
# Then I am redirected back to the bulk discount index
# And I see my new bulk discount listed

  it "US2: can create a new bulk discount" do 
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
    discount1 = BulkDiscount.create!(percentage: 20, quantity_threshold: 10, merchant_id: merchant1.id)
    
    merchant2 = Merchant.create!(name: "Rendolyn Guiz's poke stops")
    discount2 = BulkDiscount.create!(percentage: 10, quantity_threshold: 10, merchant_id: merchant2.id)
    
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")
    discount3 = BulkDiscount.create!(percentage: 5, quantity_threshold: 10, merchant_id: merchant3.id)
    
    visit "/merchants/#{merchant1.id}/bulk_discounts"

    expect(page).to have_link('Create New Bulk Discount')
    click_on ('Create New Bulk Discount')
    expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts/new")

    fill_in 'percentage', with: '5'
    fill_in 'quantity_threshold', with: '5'
    click_on ('Submit')
    expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts")
    expect(page).to have_content("Percentage Discount: 5%")
    expect(page).to have_content("Quantity Threshold: 5")

    visit "/merchants/#{merchant2.id}/bulk_discounts"

    expect(page).to have_link('Create New Bulk Discount')
    click_on ('Create New Bulk Discount')
    expect(current_path).to eq("/merchants/#{merchant2.id}/bulk_discounts/new")

    fill_in 'percentage', with: '25'
    fill_in 'quantity_threshold', with: '55'
    click_on ('Submit')
    expect(current_path).to eq("/merchants/#{merchant2.id}/bulk_discounts")
    expect(page).to have_content("Percentage Discount: 25%")
    expect(page).to have_content("Quantity Threshold: 55")

    visit "/merchants/#{merchant3.id}/bulk_discounts"

    expect(page).to have_link('Create New Bulk Discount')
    click_on ('Create New Bulk Discount')
    expect(current_path).to eq("/merchants/#{merchant3.id}/bulk_discounts/new")

    fill_in 'percentage', with: '15'
    fill_in 'quantity_threshold', with: '12'
    click_on ('Submit')
    expect(current_path).to eq("/merchants/#{merchant3.id}/bulk_discounts")
    expect(page).to have_content("Percentage Discount: 15%")
    expect(page).to have_content("Quantity Threshold: 12")
  end
end