require 'rails_helper'
require 'helpers/session_helper'
require 'helpers/restaurants_helper_spec'

feature 'restaurants' do
  include SessionHelper
  include RestaurantHelper

  context 'user hasn\'t log in' do
    scenario 'should not display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).not_to have_link 'Add a restaurant'
    end
  end

  context 'user has logged in' do
      before do
        session_start('test@test.com')
      end

    context 'no restaurants have been added' do
      scenario 'should display a prompt to add a restaurant' do
        visit '/restaurants'
        expect(page).to have_content 'No restaurants yet'
        expect(page).to have_link 'Add a restaurant'
      end
    end

    context 'restaurants have been added' do
      before do
        create_restaurant('KFC')
      end

      scenario 'display restaurants' do
        visit '/restaurants'
        expect(page).to have_content('KFC')
        expect(page).not_to have_content('No restaurants yet')
      end
    end

    context 'creating restaurants' do
      scenario 'prompts user to fill out a form, than displays the new restaurant' do
        create_restaurant('KFC')
        expect(page).to have_content 'KFC'
        expect(current_path).to eq '/restaurants'
      end

      context 'an invalid restaurant' do
        it 'does not let you submit a name that is too short' do
          visit '/restaurants'
          click_link 'Add a restaurant'
          fill_in 'Name', with: 'kf'
          click_button 'Create Restaurant'
          expect(page).not_to have_css 'h2', text: 'kf'
          expect(page).to have_content 'error'
        end
      end
    end

    context 'viewing restaurants' do
      before do
        create_restaurant('KFC')
      end

      scenario 'lets a user view a restaurant' do
        visit '/restaurants'
        click_link 'KFC'
        expect(page).to have_content 'KFC'
      end
    end

    context 'editing restaurants' do
      before do
        create_restaurant('KFC')
      end

      scenario 'let a user edit a restaurant' do
        visit '/restaurants'
        click_link 'Edit KFC'
        fill_in 'Name', with: 'Kentucky Fried Chicken'
        click_button 'Update Restaurant'
        expect(page).to have_content 'Kentucky Fried Chicken'
        expect(current_path).to eq '/restaurants'
      end

      scenario 'user cannot edit a restaurant he hasn\'t created' do
        click_link('Sign out')
        session_start('another@test.com')
        expect(page).not_to have_content('Edit KFC')
      end
    end

    context 'deleting restaurants' do
      before do
        create_restaurant('KFC')
      end

      scenario 'removes a restaurant when a user clicks a delete link' do
        visit '/restaurants'
        click_link 'Delete KFC'
        expect(page).not_to have_content 'KFC'
        expect(page).to have_content 'Restaurant deleted successfully'
      end

      scenario 'user cannot delete a restaurant if he hasn\'t created' do
        click_link('Sign out')
        session_start('another@test.com')
        expect(page).not_to have_content('Delete KFC')
      end
    end
  end
end
