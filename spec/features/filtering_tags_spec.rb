feature 'filtering tags' do
  scenario 'user filters links tagged with bubbles' do
    visit 'links/new'
    fill_in :url, with: 'http://www.google.com'
    fill_in :title, with: 'Google'
    click_button 'Add'

    visit '/links/new'
    fill_in :url, with: 'http://www.yahoo.com'
    fill_in :title, with: 'Yahoo'
    fill_in :tag, with: 'bubbles'
    click_button 'Add'

    visit '/tags/bubbles'
    expect(page).to have_content('bubbles')
    expect(page).not_to have_content('Google')
  end
end
