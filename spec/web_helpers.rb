def adding_new_link
  visit '/links/new'
  fill_in 'title', with: 'Github'
  fill_in 'url', with: 'https://github.com'
  fill_in 'tag', with: 'course'
  click_button 'bookmark'
end

def sign_up(username: "example",
            email: "example@gmail.com",
            password: "abcd",
            password_confirmation: "abcd")

  visit '/sign-up'
  expect(page.status_code).to eq(200)
  fill_in 'username', with: username
  fill_in 'email', with: email
  fill_in 'password', with: password
  fill_in 'password_confirmation', with: password_confirmation
end
