require 'rails_helper'

RSpec.describe GithubService do
  subject = GithubService.new('kerjihriohbjfdncjkbckjwbuwef')

  it 'exists' do
    expect(subject).to be_a GithubService
  end

  context '#repositories_by_user' do
    it 'returns repos when valid user token is passed in' do
      stub_data = File.read('./fixtures/github_repos_by_user.json')

      stub_request(:get, 'https://api.github.com/user/repos').to_return(status: 200, body: stub_data)

      user_repos = subject.repositories_by_user

      expect(user_repos).to be_an Array
      expect(user_repos.count).to eq(7)
      expect(user_repos.first).to be_a Hash
      expect(user_repos.first).to have_key(:name)
      expect(user_repos.first).to have_key(:html_url)
    end
  end

  context '#followers_by_user' do
    it 'returns followers when a valid user token is passed in' do
      stub_data = File.read('./fixtures/github_followers_by_user.json')

      stub_request(:get, 'https://api.github.com/user/followers').to_return(status: 200, body: stub_data)

      user_repos = subject.followers_by_user

      expect(user_repos).to be_an Array
      expect(user_repos.count).to eq(5)
      expect(user_repos.first).to be_a Hash
      expect(user_repos.first).to have_key(:login)
      expect(user_repos.first).to have_key(:html_url)
    end
  end
end
