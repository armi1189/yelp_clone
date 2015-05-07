require 'rails_helper'

module RestaurantHelper
  def create_restaurant(name)
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: name
    click_button 'Create Restaurant'
  end
end
