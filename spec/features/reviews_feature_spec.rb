require 'rails_helper'
require 'helpers/session_helper'
require 'helpers/restaurants_helper_spec'
require 'helpers/reviews_helper_spec'

feature 'reviewing' do

  include SessionHelper
  include RestaurantHelper
  include ReviewHelper

  before do
    session_start('test@test.com')
    create_restaurant('KFC')
  end

  scenario 'allows logged in users to leave a review using a form' do
    leave_review('so so', '3')
    expect(page).to have_content('so so')
  end

  scenario 'a user cannot leave more than two reviews for each restaurant' do
    leave_review('so so', '3')
    leave_review('so so', '3')
    expect(page).to have_content('You have already reviewed this restaurant')
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('So so', '3')
    click_link('Sign out')
    session_start('another@test.com')
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
  end

  context 'deleting reviews' do
    before do
      leave_review('so so', '3')
    end

    scenario 'a user can delete his own reviews' do
      visit '/restaurants'
      click_link 'Delete review'
      expect(page).not_to have_content 'so so'
      expect(page).to have_content 'Review deleted successfully'
    end

    scenario 'user cannot delete other people reviews' do
      click_link('Sign out')
      session_start('another@test.com')
      expect(page).not_to have_content('Delete Review')
    end
  end
end
