require 'rails_helper'

RSpec.describe "Merchant's Bulk Discounts Index", type: :feature do 

# Merchant Bulk Discounts Index

# As a merchant
# When I visit my merchant dashboard
# Then I see a link to view all my discounts
# When I click this link
# Then I am taken to my bulk discounts index page
# Where I see all of my bulk discounts including their
# percentage discount and quantity thresholds
# And each bulk discount listed includes a link to its show page
  it "has a link to view all discounts on a merchant's dashboard" do 
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
	  merchant2 = Merchant.create!(name: "Rendolyn Guiz's poke stops")
	  merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("#{merchant1.name}")
    expect(page).to_not have_content("#{merchant2.name}")

    expect(page).to have_link('View all discounts')
    click_on 'View all discounts'
    expect(current_path).to eq("/merchants/#{merchant1.id}/bulk_discounts") 
  end
end