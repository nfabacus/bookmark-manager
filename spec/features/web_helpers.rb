def adding_new_link
  visit '/links/new'
  fill_in 'title', with: 'Github'
  fill_in 'url', with: 'https://github.com'
  fill_in 'tag', with: 'course'
  click_button 'bookmark'
end

def sign_up
  visit '/signup'
  expect(page.status_code).to eq(200)
  fill_in 'username', with: 'Fran'
  fill_in 'email', with: 'fran@makers.com'
  fill_in 'password', with: 'guitar1234'
  fill_in 'password_confirmation', with: 'piano1234'
end
