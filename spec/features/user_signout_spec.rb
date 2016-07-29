feature 'User can sign out from the website' do
  scenario 'I can sign out from the website' do
    sign_up
    click_button 'signup'
    visit '/sign-in'
    fill_in 'email', with: 'example@gmail.com'
    fill_in 'password', with: 'abcd'
    click_button 'sign-in'
    click_button 'sign out'
    expect(page).to have_content('You are signed out. Good bye!')
    expect(page).not_to have_content('Welcome, example')
  end
end
