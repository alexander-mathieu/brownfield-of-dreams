class UserShowFacade
  attr_reader :token

  def initialize(user)
    @user = user
    @token = user.github_token
  end

  def followers
    users = github_service.followers_by_user

    users.map do |user|
      GitHub::User.new(user)
    end
  end

  def following
    users = github_service.following_by_user

    users.map do |user|
      GitHub::User.new(user)
    end
  end

  def repositories(quantity = 5)
    repos = github_service.repositories_by_user

    repos[0..(quantity - 1)].map do |repo|
      GitHub::Repository.new(repo)
    end
  end

  def bookmarks
    Video.user_bookmarks(@user.id)
  end

  private

  def github_service
    GithubService.new(@token)
  end
end
