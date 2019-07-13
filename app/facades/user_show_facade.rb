class UserShowFacade
  attr_reader :token

  def initialize(user)
    @user = user
    @token = user.github_token
  end

  def followers
    @_github_followers ||= github_service.followers_by_user

    @_github_followers.map do |follower|
      GitHub::User.new(follower)
    end
  end

  def following
    @_github_following ||= github_service.following_by_user

    @_github_following.map do |following|
      GitHub::User.new(following)
    end
  end

  def repositories
    @_repos ||= github_service.repositories_by_user

    @_repos.map do |repo|
      GitHub::Repository.new(repo)
    end
  end

  def bookmarks
    Video.user_bookmarks(@user.id)
  end

  private

  def github_service
    @_github_service ||= GithubService.new(@token)
  end
end
