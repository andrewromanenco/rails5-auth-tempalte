module Registration
  class GoogleService
    def initialize(access_token)
      @access_token = access_token
    end

    def full_name
      person = GooglePlus::Person.get('me', access_token: @access_token)
      'No name' unless person
      person.display_name
    end
  end
end
