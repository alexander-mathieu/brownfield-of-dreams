module GitHub
  class User
    attr_reader :name,
                :html_url

    def initialize(attributes)
      @name = attributes[:login]
      @html_url = attributes[:html_url]
    end
  end
end
