require 'rails_helper'
require_relative './feature_helper.rb'


feature 'reviewing' do

  scenario 'allows user to leave a review using a form' do
    sign_up
    create_restaurant
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    click_link 'KFC'
    expect(page).to have_content('so so')
  end

  scenario 'displays an average rating for all reviews' do
    sign_up
    create_restaurant
    leave_review('So so', '3')
    click_link 'Sign out'
    another_sign_up
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
  end

end
