class GithubService
  def initialize(user_token)
    @user_token = user_token
  end

  def user_query(github_handle)
    get_json("/users/#{github_handle}")
  end

  def followers_by_user
    get_json('/user/followers')
  end

  def following_by_user
    get_json('/user/following')
  end

  def repositories_by_user
    get_json('/user/repos', { sort: 'updated' })
  end

  private

  def get_json(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.headers['Authorization'] = "token #{@user_token}"
      f.headers['Accept'] = 'v3'
      f.adapter Faraday.default_adapter
    end
  end
end
