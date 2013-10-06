require 'spec_helper'

describe 'An user', js: true do
  it 'can sign in if they have signed up' do
    email = generate(:email)
    password = generate(:password)
    user = create(:user, email: email, password: password)

    visit new_user_session_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Sign in'

    expect(page).to have_content('Signed in successfully.')
  end

  it 'cannot sign in if they have not signed up' do
    email = generate(:email)
    password = generate(:password)

    visit new_user_session_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Sign in'

    expect(page).to_not have_content('Signed in successfully.')
  end

  it 'cannot sign in if a field is ommitted' do
    email = generate(:email)
    password = generate(:password)
    user = create(:user, email: email, password: password)

    visit new_user_session_path

    fill_in 'Email', with: email
    click_on 'Sign in'

    expect(page).to_not have_content('Signed in successfully.')
  end

  it 'can sign out if they are signed in' do
    email = generate(:email)
    password = generate(:password)
    user = create(:user, email: email, password: password)

    visit new_user_session_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Sign in'

    expect(page).to have_content('Signed in successfully.')

    click_link 'Log Out'

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
