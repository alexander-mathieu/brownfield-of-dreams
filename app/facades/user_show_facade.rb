class UserShowFacade
  def initialize(user)
    @user = user
  end

  def repositories
    conn = Faraday.new(url: "https://api.github.com") do |f|
      f.headers["Authorization"] = @user.github_token
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/user/repos")
    @repos = JSON.parse(response.body, symbolize_names: true)

    @repos.map do |repo|
      GitHub::Repository.new(repo)
    end
  end

end
