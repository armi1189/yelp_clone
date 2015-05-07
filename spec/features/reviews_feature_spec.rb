require 'rails_helper'
require 'helpers/session_helper'
require 'helpers/reviews_helper_spec'

feature 'reviewing' do

  include SessionHelper
  include ReviewHelper

  before { Restaurant.create name: 'KFC' }

  before do
    session_start('test@test.com')
  end

  scenario 'allows logged in users to leave a review using a form' do
    visit '/restaurants'
    leave_review
    expect(page).to have_content('so so')
  end

  scenario 'a user cannot leave more than two reviews for each restaurant' do
    visit '/restaurants'
    leave_review
    visit '/restaurants'
    leave_review
    expect(page).to have_content('You have already reviewed this restaurant.')
  end

  context 'deleting reviews' do
    before do
      leave_review
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
