feature 'create user account' do
  scenario 'I can sign up as a new user' do
    visit '/sign-up'
    fill_in 'username', with: 'Fran'
    fill_in 'email', with: 'fran@makers.com'
    fill_in 'password', with: 'guitar1234'
    fill_in 'password_confirmation', with: 'guitar1234'
    expect{ click_button 'signup' }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, Fran')
    expect(User.first.email).to eq('fran@makers.com')
  end

  scenario 'no new user is created with mismatching passwords' do
    visit '/sign-up'
    fill_in 'username', with: 'Fran'
    fill_in 'email', with: 'fran@makers.com'
    fill_in 'password', with: 'guitar1234'
    fill_in 'password_confirmation', with: 'piano1234'
    expect { click_button 'signup' }.not_to change(User, :count)
    expect(current_path).to eq('/newuser')
    expect(page).to have_content("Password and confirmation password do not match")
  end

  scenario 'I can not sign up without entering an email' do
    visit '/sign-up'
    fill_in 'username', with: 'Fran'
    fill_in 'email', with: ''
    fill_in 'password', with: 'guitar1234'
    fill_in 'password_confirmation', with: 'guitar1234'
    expect { click_button 'signup' }.not_to change(User, :count)
    expect(current_path).to eq('/newuser')
    expect(page).to have_content("Please enter your email address.")
  end

  scenario 'I can not sign up using an invalid email format' do
    visit '/sign-up'
    fill_in 'username', with: 'Fran'
    fill_in 'email', with: 'text'
    fill_in 'password', with: 'guitar1234'
    fill_in 'password_confirmation', with: 'guitar1234'
    expect { click_button 'signup' }.not_to change(User, :count)
    # expect(current_path).to eq('/sign-up')
    # expect(page).to have_content("Invalid email format")
  end
end
