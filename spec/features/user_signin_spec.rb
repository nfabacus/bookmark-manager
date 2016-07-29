feature 'User can sign in to the website' do
  scenario 'I can sign in using my email and password' do
    sign_up
    click_button 'signup'
    visit '/sign-in'
    fill_in 'email', with: 'example@gmail.com'
    fill_in 'password', with: 'abcd'
    click_button 'sign-in'
    expect(page).to have_content('Welcome, example')
  end
end
