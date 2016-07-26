feature 'create links' do
  scenario 'adding a new link to bookmark manager' do
    visit '/links/new'
    fill_in :url, with: 'http://www.google.com'
    fill_in :title, with: 'Google'
    click_button 'Add'

    within 'ul#links' do
      expect(page).to have_content('Google')
    end
  end
end
