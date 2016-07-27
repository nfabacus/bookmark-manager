feature 'user signing up for user account' do
  scenario 'user signs up' do
    visit '/user/sign-up'
    fill_in :e_mail, with: "s.yalniz@hotmail.de"
    fill_in :password, with: "1234567"
    expect{click_button "Sign-up"}.to change{User.count}.by 1
    expect(page).to have_content("Welcome")
    user = User.first
    expect(user.e_mail).to eq "s.yalniz@hotmail.de"
  end
end
