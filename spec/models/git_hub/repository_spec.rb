require 'rails_helper'

RSpec.describe GitHub::Repository do
  before :each do
    attributes = { name: "Repository the Whirlwind",
                   html_url: "https://getsome.com" }

    @repository = GitHub::Repository.new(attributes)
  end

  it 'exists' do
    expect(@repository).to be_a(GitHub::Repository)
  end

  it 'attributes' do
    expect(@repository.name).to eq("Repository the Whirlwind")
    expect(@repository.html_url).to eq("https://getsome.com")
  end
end
