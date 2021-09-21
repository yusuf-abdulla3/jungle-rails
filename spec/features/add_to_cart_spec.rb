require 'rails_helper'

RSpec.feature "Add to cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
         image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Adding to cart increases cart count" do
    # ACT
    visit root_path
    expect(page).to have_content 'My Cart (0)'
    click_on('Add')

    # DEBUG
    sleep 1
    save_screenshot

    # VERIFY
    expect(page).to have_content 'My Cart (1)'

  end
end