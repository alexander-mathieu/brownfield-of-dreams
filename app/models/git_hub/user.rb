# frozen_string_literal: true

class GitHub::User
  attr_reader :name,
              :html_url,
              :uid,
              :email

  def initialize(attributes)
    @name = attributes[:login]
    @html_url = attributes[:html_url]
    @uid = attributes[:id]
    @email = attributes[:email]
  end

  def registered?
    !User.find_by(github_uid: @uid).nil?
  end
end
