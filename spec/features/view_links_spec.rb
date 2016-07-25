feature 'view links' do
  scenario 'I would like to see a list of links' do
    visit '/'
    expect(page).to have_link("BBC", :href => "www.bbc.co.uk")
  end
end
