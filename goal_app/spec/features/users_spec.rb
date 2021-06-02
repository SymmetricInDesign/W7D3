# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content(/email/i)
    expect(page).to have_content(/email/i)
  end

  feature 'signing up a user' do
    before(:each) do
        visit new_user_url
        fill_in 'email', with: 'testing@email.com'
        fill_in 'password', with: 'biscuits'
        click_on 'Create User'
    end
    scenario 'shows username on the homepage after signup' do
        expect(page).to have_content "testing@email.com"
    end

  end
end

feature 'logging in' do
  before(:each) do
      visit new_session_url
      fill_in 'email', with: 'testing@email.com'
      fill_in 'password', with: 'biscuits'
      click_on 'Log In'
  end    
  scenario 'shows username on the homepage after login' do
    expect(page).to have_content "testing@email.com"
  end

end

feature 'logging out' do
  scenario 'begins with a logged in state' do
    expect(page).to have_content "Welcome"
  end
  scenario 'doesn\'t show username on the homepage after logout' do
    click_on 'Log Out'
    expect(page).not_to have_content "Welcome"
  end

end