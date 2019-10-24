require('capybara/rspec')
require './app'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create a word path', {:type => :feature}) do
  it("creates a word and goes to the word page") do
    visit('/words')
    click_on('Add a new word')
    fill_in('word_name', :with => 'Fumple')
    click_on('Add')
    expect(page).to have_content('Fumple')
  end
end

describe('create a definition path', {:type => :feature}) do
  it("creates a definition from a word page, and then goes to the definition page") do
    word = Word.new("Fumple", nil)
    word.save
    visit("/words/#{word.id}")
    fill_in('definition_name', :with => "To fall and do a somersault")
    click_on('Add definition')
    expect(page).to have_content("To fall and do a somersault")
  end
end
