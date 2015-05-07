require 'rails_helper'

module ReviewHelper
  def leave_review(thoughts, rating)
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end
end