class UserShowFacade
  def initialize(user)
    @user = user
    @token = user.github_token
  end

  def repositories(quantity = 5)
    repos = github_service.repositories_by_user

    repos[0..(quantity - 1)].map do |repo|
      GitHub::Repository.new(repo)
    end
  end

  private

  def github_service
    GithubService.new(@token)
  end

end
