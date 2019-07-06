Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB-CLIENT-ID'], ENV['GITHUB-CLIENT-SECRET'], scope: 'repo'
end
