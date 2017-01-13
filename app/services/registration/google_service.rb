module Registration
  class GoogleService
    def initialize(access_token)
      @access_token = access_token
    end

    def full_name
      begin
        person = GooglePlus::Person.get('me', access_token: @access_token)
        person.display_name
      rescue RuntimeError => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.join("\n")
        ''
      end
    end
  end
end
