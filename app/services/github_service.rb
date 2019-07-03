class GithubService
  def initialize(user_token)
    @user_token = user_token
  end

  def repositories_by_user
    get_json("/user/repos")
  end

  private

  def get_json(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.headers["Authorization"] = "token #{@user_token}"
      f.adapter Faraday.default_adapter
    end
  end

end
