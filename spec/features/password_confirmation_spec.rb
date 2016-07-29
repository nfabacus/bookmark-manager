feature 'password confirmation' do
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
end
