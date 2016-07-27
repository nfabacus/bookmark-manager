feature 'adding multiple tags' do
  scenario 'User adds multiple tags to a new link' do
    visit '/links/new'
    fill_in :url, with: 'http://www.google.com'
    fill_in :title, with: 'Google'
    fill_in :tag, with: 'search-engine, bubbles'

    click_button 'Add'
    link = Link.first
    expect(link.tags.map(&:name)).to include('search-engine')
    expect(link.tags.map(&:name)).to include('bubbles')
  end
end
