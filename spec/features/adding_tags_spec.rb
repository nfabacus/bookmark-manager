feature 'User creates a new link with a tag' do
  scenario 'allows user to add a tag to a link' do
    visit '/links/new'
    fill_in :url, with: 'http://www.google.com'
    fill_in :title, with: 'Google'
    fill_in :tag, with: 'search engine'
    click_button 'Add'

    within 'ul#links' do
      expect(page).to have_content('search engine')
    end
  end
end
