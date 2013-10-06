require 'spec_helper'

describe 'A new user', js: true do
  it 'is able to sign up' do
    email = generate(:email)
    password = generate(:password)
    visit new_user_registration_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  it 'is unable to sign up if they omit a field' do
    email = generate(:email)
    password = generate(:email)
    visit new_user_registration_path

    fill_in 'Email', with: email

    click_button 'Sign up'

    expect(page).to_not have_content 'Welcome! You have signed up successfully.'
  end
end
