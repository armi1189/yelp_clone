require 'rails_helper'

module SessionHelper
  def session_start(user)
    visit '/'
    click_link 'Sign up'
    fill_in('Email', with: user)
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end
end